-- liquibase formatted sql

-- changeset dmitry:CREATING_SCHEMA_LIBRARYSCHEMA
CREATE SCHEMA IF NOT EXISTS libraryschema AUTHORIZATION postgres;
SET search_path TO libraryschema,public,"$user";