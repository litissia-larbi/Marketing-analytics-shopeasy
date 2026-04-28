
import pandas as pd
import pyodbc #biblotheque pour se connecter a une base de donnees SQL Server
import nltk   #bibliotheque pour le traitement du langage naturel NLP
from nltk.sentiment.vader import SentimentIntensityAnalyzer #importer l'analyseur de sentiment VADER 


#telecharger le lexique VADER pour l'analyse de sentiment s'il n'est pas deja present
nltk.download('vader_lexicon')

#definir une fonction pour recuperer les donnees d'une base de donnees SQL
def fetch_data_from_sql():
    # definir la chaine de connexion avec les parametres pour la connexion a la base de donnees
    conn_str = (
        "Driver={SQL Server};"  # specifier le pilote pour SQL Server
        "Server=WIN-9PDLGUG4O1C\SQLEXPRESS;"  # specifier votre instance SQL Server
        "Database=PortfolioProject_MarketingAnalytics;"  # specifier le nom de la base de donnees
        "Trusted_Connection=yes;"  # utiliser l'authentification Windows pour la connexion
    )
    # Etablir la connexion a la base de donnees
    conn = pyodbc.connect(conn_str)
    
    # definir la requete SQL pour recuperer les donnees de la table des avis clients
    query = "SELECT ReviewID, CustomerID, ProductID, ReviewDate, Rating, ReviewText FROM dbo.fact_customer_reviews"
    
    # executer la requete et recuperer les donnees dans un DataFrame
    df = pd.read_sql(query, conn)
    
    # fermer la connexion pour liberer les ressources
    conn.close()
    
    # retourner les donnees recuperees sous forme de DataFrame
    return df


# Recuperer les donnees des avis clients de la base de donnees SQL
customer_reviews_df = fetch_data_from_sql()

# Initialiser l'analyseur VADER pour analyser le sentiment des donnees textuelles
sia = SentimentIntensityAnalyzer()

# Definir une fonction pour calculer les scores de sentiment en utilisant VADER
def calculate_sentiment(review):
    # Obtenir les scores de sentiment pour le texte de l'avis
    # sia.polarity_scores(review) retourne un dictionnaire avec 4 clés : neg, neu, pos et compound
    #on conserve uniquement compound : un score normalisé entre -1 (très négatif) et +1 (très positif)
    sentiment = sia.polarity_scores(review)
    # Return the compound score, which is a normalized score between -1 (most negative) and 1 (most positive)
    return sentiment['compound']


# definir une fonction pour catégoriser le sentiment en utilisant
# à la fois le score de sentiment et la note de l'avis (rating recupere depuis la base de donnees)
def categorize_sentiment(score, rating):
    # utriliser à la fois le score de sentiment textuel et la note numérique
    if score > 0.05:  # sentiment positif
        if rating >= 4:
            return 'Positive'  # rating élevé et sentiment positif
        elif rating == 3:
            return 'Mixed Positive'  # Note neutre mais sentiment positif
        else:
            return 'Mixed Negative'  # Note faible mais sentiment positif
    elif score < -0.05:  # sentiment négatif
        if rating <= 2:
            return 'Negative'  # rating faible et sentiment négatif
        elif rating == 3:
            return 'Mixed Negative'  # Note neutre mais sentiment négatif
        else:
            return 'Mixed Positive'  # Note élevée mais sentiment négatif
    else:  # sentiment neutre
        if rating >= 4:
            return 'Positive'  # note élevée avec sentiment neutre
        elif rating <= 2:
            return 'Negative'  # note faible avec sentiment neutre
        else:
            return 'Neutral'  # note neutre avec sentiment neutre

# definir une fonction pour catégoriser les scores de sentiment en intervalles
def sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 to 1.0'  # sentiment fortement positif
    elif 0.0 <= score < 0.5:
        return '0.0 to 0.49'  # sentiment modérément positif
    elif -0.5 <= score < 0.0:
        return '-0.49 to 0.0'  # sentiment moderément négatif
    else:
        return '-1.0 to -0.5'  # sentiment fortement négatif

# Apliquer le calcul du score de sentiment
customer_reviews_df['SentimentScore'] = customer_reviews_df['ReviewText'].apply(calculate_sentiment)

# Appliquer la catégorisation du sentiment en utilisant à la fois le score et la note
customer_reviews_df['SentimentCategory'] = customer_reviews_df.apply(
    lambda row: categorize_sentiment(row['SentimentScore'], row['Rating']), axis=1)

# Apliquer la catégorisation des scores de sentiment en intervalles
customer_reviews_df['SentimentBucket'] = customer_reviews_df['SentimentScore'].apply(sentiment_bucket)

# Afficher les premières lignes du DataFrame enrichi avec les scores et catégories de sentiment
print(customer_reviews_df.head())

# Enregistrer le DataFrame enrichi dans un fichier CSV
customer_reviews_df.to_csv('fact_customer_reviews_with_sentiment.csv', index=False)
