-- ===========================================================
-- Script SQL : Nettoyage et normalisation de la table engagement_data
-- Objectif : créer une table nettoyée avec les colonnes normalisées et filtrées
-- Nouvelle table créée : fact_engagement_data_cleaned
-- ===========================================================

USE PortfolioProject_MarketingAnalytics;
GO

-- ===========================================================
-- Vérifier le contenu de la table source
-- ===========================================================
SELECT TOP 10 *
FROM dbo.engagement_data;

-- ===========================================================
-- Créer une nouvelle table nettoyée
-- ===========================================================
DROP TABLE IF EXISTS dbo.fact_engagement_data_cleaned;  -- Supprimer la table précédente si elle existe
GO

SELECT 
    EngagementID,  -- Identifiant unique de chaque engagement
    ContentID,     -- Identifiant unique de chaque contenu
    CampaignID,    -- Identifiant unique de chaque campagne marketing
    ProductID,     -- Identifiant unique de chaque produit

    -- Nettoyage et normalisation du type de contenu
    UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,  
    -- Remplace "Socialmedia" par "Social Media" et met tout en majuscules

    -- Séparer Views et Clicks à partir de la colonne combinée ViewsClicksCombined
    LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views,  
    -- Prend la partie avant le tiret comme nombre de vues
    RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,  
    -- Prend la partie après le tiret comme nombre de clics

    Likes,  -- Nombre de likes reçus par le contenu

    -- Normalisation de la date au format dd.MM.yyyy
    FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate  

INTO dbo.fact_engagement_data_cleaned  -- Créer une nouvelle table à partir du résultat
FROM 
    dbo.engagement_data  -- Table source
WHERE 
    ContentType != 'Newsletter';  -- Exclure les newsletters qui ne sont pas pertinentes

-- ===========================================================
-- Vérifier que la nouvelle table a bien été créée
-- ===========================================================
SELECT TOP 10 *
FROM dbo.fact_engagement_data_cleaned;
