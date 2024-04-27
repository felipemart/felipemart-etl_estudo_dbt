{{ config(materialized='view') }}
with source as (
    select
        id,
        id_produtos,
        id_vendas,
        valor::DECIMAL(10,2) as valor
    from {{ source('sources', 'vendas_itens') }}
)

select
    id,
    id_produtos,
    id_vendas,
    valor
from source