-- ===========================================================
-- Script SQL : Catégoriser les produits selon leur prix
-- Objectif : créer une table enrichie avec une nouvelle colonne "PriceCategory"
-- Nouvelle table créée : fact_products_price_category
-- ===========================================================

USE PortfolioProject_MarketingAnalytics;
GO

-- ===========================================================
-- Vérifier le contenu de la table source
-- ===========================================================
SELECT 
    TOP 10 *
FROM 
    dbo.products;  -- Table d'origine contenant les informations sur les produits

-- ===========================================================
-- Créer une nouvelle table avec une catégorisation des produits selon leur prix
-- ===========================================================
SELECT 
    ProductID,       -- Sélectionner l'identifiant unique de chaque produit
    ProductName,     -- Sélectionner le nom de chaque produit
    Price,           -- Sélectionner le prix du produit

    -- Créer une nouvelle colonne "PriceCategory" en fonction du prix
    CASE 
        WHEN Price < 50 THEN 'Low'             -- Si le prix est inférieur à 50 DONC  catégorie 'Low'
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'  -- Si le prix est compris entre 50 et 200 DONC catégorie 'Medium'
        ELSE 'High'                            -- Si le prix est supérieur à 200 DONC catégorie 'High'
    END AS PriceCategory                       -- Nom de la nouvelle colonne

INTO dbo.fact_products_price_category           -- Créer une nouvelle table à partir du résultat
FROM 
    dbo.products;                              -- Spécifier la table source

-- ===========================================================
-- Vérifier que la nouvelle table a bien été créée
-- ===========================================================
SELECT TOP 10 *
FROM dbo.fact_products_price_category;
