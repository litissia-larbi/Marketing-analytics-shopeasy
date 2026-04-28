# 📊 ShopEasy Marketing Analytics

Projet personnel d'analyse marketing réalisé avec **Power BI**, **SQL Server** et **Python** 

---

## 🔍 Contexte

ShopEasy est une entreprise de vente au détail cherchant à comprendre les facteurs influençant ses performances commerciales. Ce projet analyse trois axes principaux : les taux de conversion, l'engagement sur les réseaux sociaux et la satisfaction client.

---

## ❓ Problématique

> *"Comment améliorer les taux de conversion, l'engagement client et la satisfaction produit de ShopEasy ?"*

**3 signaux d'alerte identifiés :**
- 📉 Taux de conversion en baisse avec un creux à **4,3% en mai**
- 👁️ Diminution progressive des vues sur les réseaux sociaux à partir de juin
- ⭐ Note moyenne client stagnant à **3,7/5**, en dessous de l'objectif de 4,0

---

## 🗂️ Structure du projet

```
marketing-analytics-shopeasy/
├── sql/
│   ├── dim_customers.sql           # Enrichissement données clients
│   ├── dim_products.sql            # Catégorisation produits par prix
│   ├── fact_customer_journey.sql   # Nettoyage parcours client
│   └── fact_customer_reviews.sql   # Nettoyage avis clients
├── python/
│   └── customer_reviews_enrichment.py  # Analyse de sentiment NLP (VADER)
└── screenshots/
    ├── dashboard_1_vue_ensemble.png
    ├── dashboard_2_parcours_client.png
    ├── dashboard_3_reseaux_sociaux.png
    └── dashboard_4_avis_clients.png
```

---

## → Dashboards Power BI

<table>
  <tr>
    <td align="center" width="50%">
      <b>📈 Vue d'Ensemble</b><br><br>
      <img src="screenshots/dashboard 1 .png" width="100%"/>
      <br><br>
      • Taux de conversion global : 10%<br>
      • 9 079 276 vues totales<br>
      • Note moyenne : 3,7 ⭐
    </td>
    <td align="center" width="50%">
      <b>🛒 Parcours Client</b><br><br>
      <img src="screenshots/dashboard 2.png" width="100%"/>
      <br><br>
      • Analyse View → Click → Purchase<br>
      • Taux de conversion par produit<br>
      • Hockey Stick & Ski Boots : 15%
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <b>📱 Engagement Réseaux Sociaux</b><br><br>
      <img src="screenshots/dashboard 3.png" width="100%"/>
      <br><br>
      • 1 785 010 clics<br>
      • 414 122 likes<br>
      • Analyse Blog vs Social Media vs Vidéo
    </td>
    <td align="center" width="50%">
      <b>⭐ Analyse des Avis Clients</b><br><br>
      <img src="screenshots/dashboard 4.png" width="100%"/>
      <br><br>
      • 840 avis positifs<br>
      • 226 avis négatifs<br>
      • Analyse sentiment NLP VADER
    </td>
  </tr>
</table>

---

## 🛠️ Stack technique

| Outil | Usage |
|---|---|
| **Power BI** | Dashboards interactifs |
| **SQL Server** | Nettoyage et enrichissement des données |
| **Python (NLTK/VADER)** | Analyse de sentiment NLP |
| **pyodbc / pandas** | Connexion SQL et manipulation des données |

---

## ⚙️ Pipeline de données

```
SQL Server (données brutes)
        ↓
Scripts SQL (nettoyage, enrichissement)
        ↓
Python VADER (analyse de sentiment)
        ↓
fact_customer_reviews_with_sentiment.csv
        ↓
Power BI (visualisation)
```

---

## 📈 Résultats clés

- 🔄 **Meilleur taux de conversion : Janvier à 17%** — Surfboard à 150%
- 📉 **Pire mois : Mai à 4,3%** — révision stratégie marketing nécessaire
- ⭐ **840 avis positifs** sur 1 951 avis analysés (43%)
- 📱 **Taux de clic : 15,37%** malgré une baisse des vues

---

## 💡 Recommandations

1. **Augmenter les taux de conversion** — Prioriser Surfboard, Ski Boots et Soccer Ball avec des promotions saisonnières ciblées
2. **Améliorer la satisfaction client** — Analyser les avis mixtes pour atteindre une note de 4,0/5
3. **Revitaliser l'engagement** — Tester des formats innovants (vidéos interactives, contenu généré par les utilisateurs)

---

## 👩‍💻 Auteure

**Litissia LARBI** — M1 IBD, Université Paris 8 — 2025/2026
