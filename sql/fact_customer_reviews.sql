-- Sélectionner la base sur laquelle travailler
USE PortfolioProject_MarketingAnalytics;
GO

-- Si une version précédente existe, on la supprime pour éviter une erreur
DROP TABLE IF EXISTS dbo.fact_customer_reviews;
GO

-- Créer une nouvelle table avec le texte nettoyé
SELECT 
    ReviewID,             -- ID unique de chaque review
    CustomerID,           -- ID du client
    ProductID,            -- ID du produit
    ReviewDate,           -- Date du commentaire
    Rating,               -- Note donnée par le client
    REPLACE(ReviewText, '  ', ' ') AS ReviewText  -- Nettoyage : remplace les doubles espaces
INTO 
    dbo.fact_customer_reviews            --  Nouvelle table créée ici
FROM 
    dbo.customer_reviews;                          -- Table source
