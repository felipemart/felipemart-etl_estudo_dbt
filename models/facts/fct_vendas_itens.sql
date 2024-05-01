{{ config(materialized='incremental', unique_key='venda_item_id') }}
with vendas_itens as (
    select
        vi.id as venda_item_id,
        vi.id_produtos as produto_id,
        vi.id_vendas, 
        vi.valor::DECIMAL(10,2) as valor_pago
    from {{ ref("stg_vendas_itens") }} vi
    join {{ ref("dim_produtos")}} p on vi.id_produtos = p.produto_id
    join {{ ref("fct_vendas")}} v on vi.id_vendas = v.id
)


select 
    venda_item_id,
    produto_id,
    id_vendas,
    valor_pago
from vendas_itens
{% if is_incremental() %}
    where venda_item_id > (select MAX(venda_item_id) from {{ this }})
{% endif %}