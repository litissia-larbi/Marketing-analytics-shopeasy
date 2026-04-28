-- ===========================================================
-- Script SQL : Identifier et supprimer les doublons dans la table customer_journey
-- Objectif : créer une table nettoyée avec les doublons supprimés
-- Nouvelle table créée : fact_customer_journey_cleaned
-- ===========================================================

USE PortfolioProject_MarketingAnalytics;
GO

-- ===========================================================
-- Vérifier le contenu de la table source
-- ===========================================================
SELECT TOP 10 *
FROM dbo.customer_journey;

-- ===========================================================
-- Étape 1 : Identifier les doublons à l'aide d'une CTE (Common Table Expression)
-- ===========================================================
WITH DuplicateRecords AS (
    SELECT 
        JourneyID,    -- Identifiant unique de chaque parcours client
        CustomerID,   -- Identifiant unique du client
        ProductID,    -- Identifiant unique du produit
        VisitDate,    -- Date de la visite
        Stage,        -- Étape du parcours client (Awareness, Consideration, etc.)
        Action,       -- Action réalisée par le client (View, Click, Purchase)
        Duration,     -- Durée de l'action ou de l'interaction

        -- Numérotation des lignes pour détecter les doublons
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action  
            ORDER BY JourneyID
        ) AS row_num  -- row_num > 1 indique un doublon
    FROM dbo.customer_journey
)

-- ===========================================================
-- Étape 2 : Visualiser les doublons identifiés
-- ===========================================================
SELECT *
FROM DuplicateRecords
WHERE row_num > 1  -- Affiche uniquement les doublons (la première occurrence est conservée)
ORDER BY JourneyID;

-- ===========================================================
-- Étape 3 : Créer une nouvelle table nettoyée sans doublons
-- ===========================================================
DROP TABLE IF EXISTS dbo.fact_customer_journey_cleaned;  -- Supprimer la table existante si nécessaire
GO

SELECT 
    JourneyID,  
    CustomerID,  
    ProductID,  
    VisitDate,  
    Stage,  
    Action,  
    COALESCE(Duration, avg_duration) AS Duration  -- Remplacer les valeurs manquantes par la moyenne pour la date
INTO dbo.fact_customer_journey_cleaned  -- Créer la nouvelle table nettoyée
FROM (
    -- Sous-requête pour préparer et nettoyer les données
    SELECT 
        JourneyID,  
        CustomerID,  
        ProductID,  
        VisitDate,  
        UPPER(Stage) AS Stage,  -- Convertir Stage en majuscules pour uniformité
        Action,  
        Duration,  
        AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,  -- Calculer la moyenne par date
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action  -- Identifier les doublons
            ORDER BY JourneyID
        ) AS row_num
    FROM dbo.customer_journey
) AS subquery
WHERE row_num = 1;  -- Conserver uniquement la première occurrence de chaque groupe de doublons

-- ===========================================================
-- Vérifier le contenu de la table nettoyée
-- ===========================================================
SELECT TOP 10 *
FROM dbo.fact_customer_journey_cleaned;
