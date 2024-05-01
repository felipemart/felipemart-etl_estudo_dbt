{{ config(materialized='table') }}
select  
    id as cliente_id,
    nome as cliente_nome,
    data
from {{ ref('stg_clientes') }}