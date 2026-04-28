-- Nettoyage et enrichissement des données clients
-- Objectif : créer une table enrichie avec les informations géographiques
-- Nouvelle table créée : fact_customers_enriched
-- ================================================

USE PortfolioProject_MarketingAnalytics;
GO

-- Vérifier le contenu des tables sources
SELECT 
*
FROM dbo.customers;

SELECT
*
FROM dbo.geography;

-- ================================================
-- Créer une nouvelle table enrichie en joignant les tables customers et geography
-- On ajoute les informations de pays et ville pour chaque client
-- ================================================
SELECT 
    c.CustomerID,       -- Sélectionner l'ID de chaque client 
    c.CustomerName,     -- Sélectionner le nom de chaque client
    c.Email,            -- Sélectionner l'email de chaque client
    c.Gender,           -- Sélectionner le genre de chaque client
    c.Age,              -- Sélectionner l'âge de chaque client
    g.Country,          -- Sélectionner le pays du client pour enrichir les données
    g.City              -- Sélectionner la ville du client pour enrichir les données
INTO dbo.fact_customers_enriched  -- Créer une nouvelle table à partir du résultat de la jointure
FROM 
    dbo.customers AS c  -- Spécifier l'alias 'c' pour la table customers
LEFT JOIN
    dbo.geography AS g  -- Spécifier l'alias 'g' pour la table geography
ON 
    c.GeographyID = g.GeographyID;  -- Relier les deux tables sur la colonne GeographyID

-- ================================================
-- Vérifier que la nouvelle table a bien été créée
-- ================================================
SELECT TOP 10 *
FROM dbo.fact_customers_enriched;
