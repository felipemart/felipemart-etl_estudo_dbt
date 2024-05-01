{{ config(materialized='table')}}
select
    l.loja_descricao as loja,
    count(v.id) as quat_vendas,
    sum(vi.valor_pago) as valor_vendas,
    avg(vi.valor_pago)::DECIMAL(10,2) as valor_medio
from {{ ref('fct_vendas') }} v
join {{ ref('dim_lojas') }} l on v.loja_id = l.loja_id
join {{ ref('fct_vendas_itens') }} vi on v.id = vi.id_vendas
join {{ ref('dim_produtos') }} p on vi.produto_id = p.produto_id
group by l.loja_descricao
order by valor_vendas