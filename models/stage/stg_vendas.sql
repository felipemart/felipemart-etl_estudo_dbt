{{ config(materialized='view') }}
with source as (
    select
        id,
        data,
        id_cliente,
        id_loja
    from {{ source('sources', 'vendas') }}
)

select
    id,
    data,
    id_cliente,
    id_loja
from source