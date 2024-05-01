{{ config(materialized='table') }}
select  
    id as loja_id,
    descricao as loja_descricao
from {{ ref('stg_lojas') }}