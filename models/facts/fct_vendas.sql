{{ config(materialized='incremental', unique_key='id') }}
with vendas as (
    select
        v.id,
        v.data as data_venda,
        v.id_cliente as cliente_id,
        v.id_loja as loja_id 
    from {{ ref("stg_vendas") }} v
    join {{ ref("dim_clientes")}} c on v.id_cliente = c.cliente_id
    join {{ ref("dim_lojas")}} l on v.id_loja = l.loja_id
)


select 
    id,
    data_venda,
    cliente_id,
    loja_id
from vendas
{% if is_incremental() %}
    where id > (select MAX(id) from {{ this }})
{% endif %}