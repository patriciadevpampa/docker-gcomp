-- Migração: Adicionar coluna wo na tabela jogo
-- Data: 2025-11-14
-- Autor: Sistema

ALTER TABLE jogo ADD COLUMN IF NOT EXISTS wo VARCHAR(255);
