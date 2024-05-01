{{ config(materialized='table') }}
select  
    id as produto_id,
    descricao as produto_descricao,
    valor::DECIMAL(10,2) as valor_base
from {{ ref('stg_produtos') }}