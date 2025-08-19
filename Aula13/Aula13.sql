---- RM 559196 BRENDON BRASIL
---- RM558961 VITOR HUGO
---- RM554728 VINICIUS LEANDRO

set serveroutput on
set verify off

-- CUIDADO!! LIMPA TUDO A SEGUIR
begin
  for t in (select trigger_name from user_triggers) loop
    execute immediate 'drop trigger "' || t.trigger_name || '"';
  end loop;

  for c in (select table_name, constraint_name 
            from user_constraints 
            where constraint_type = 'R') loop
    execute immediate 'alter table "' || c.table_name || '" drop constraint "' || c.constraint_name || '"';
  end loop;

  for v in (select view_name from user_views) loop
    execute immediate 'drop view "' || v.view_name || '"';
  end loop;

  for t in (select table_name from user_tables) loop
    execute immediate 'drop table "' || t.table_name || '" cascade constraints';
  end loop;

  for p in (select object_name from user_objects where object_type = 'PROCEDURE') loop
    execute immediate 'drop procedure "' || p.object_name || '"';
  end loop;

  for f in (select object_name from user_objects where object_type = 'FUNCTION') loop
    execute immediate 'drop function "' || f.object_name || '"';
  end loop;

  for pkg in (select object_name from user_objects where object_type = 'PACKAGE') loop
    execute immediate 'drop package "' || pkg.object_name || '"';
  end loop;

  for s in (select sequence_name from user_sequences) loop
    execute immediate 'drop sequence "' || s.sequence_name || '"';
  end loop;

  for syn in (select synonym_name from user_synonyms) loop
    execute immediate 'drop synonym "' || syn.synonym_name || '"';
  end loop;

  dbms_output.put_line('banco de dados limpo com sucesso.');
end;
/

drop table cliente cascade constraints;
create table cliente 
(cod_clie number(4) constraint clie_cd_pk primary key, 
nome_clie varchar2(20) constraint clie_no_nn not null, 
endereco varchar2(30),cidade varchar2(15), 
cep char(8),uf char(2),cnpj char(16),ie char(12));

drop table vendedor cascade constraints;
create table vendedor 
(cod_ven number(4) constraint ven_cod_pk primary key, 
nome_ven varchar2(20) constraint ven_no_nn not null, 
salario_fixo number(12,2),comissao char(1));

drop table produto cascade constraints;
create table produto 
(cod_prod number(4) constraint prod_cod_pk primary key, 
qtd_prod number(5) constraint qtd_prod_nn not null,
unidade varchar2(3),descricao varchar2(20),val_unit number(10,2));

drop table pedido cascade constraints;
create table pedido 
(num_pedido number(4) constraint pedido_num_pk primary key, 
pr_entrega number(3) constraint entrega_pr_nn not null, 
cod_clie references cliente,cod_ven references vendedor);

drop table item_pedido cascade constraints;
create table item_pedido 
(num_pedido references pedido, 
cod_prod references produto, 
quant number(10,2));

insert into cliente values(720,'Ana','Rua 17 n.19','Niteroi','24358310','RJ','12113231/0001-34','2134');

insert into cliente values(870,'Flavio','Av. Pres. Vargas, 10','Sao Paulo','22763931','SP','22534126/9387-9','4631');

insert into cliente values(110,'Jorge','Rua Caiapo, 13','Curitiba','30078500','PR','14512764/9834-9',null);

insert into cliente values(222,'Lucia','Rua Itabira, 123','Belo Horizonte','22124391','MG','283152123/9348-8','2985');

insert into cliente values(830,'Mauricio','Av. Paulista, 1236','Sao Paulo','3012683','SP','32816985/7465-6','9343');

insert into cliente values(130,'Edmar','Rua da Praia, s/n','Salvador','30079300','BA','23463284/234-9','7121');

insert into cliente values(410,'Rodolfo','Largo da Lapa, 27','Rio de Janeiro','30078900','RJ','12835128/2346-9','743');

insert into cliente values(20,'Beth','Av. Climerio, 45','Sao Paulo','25679300','SP','32485126/7326-8','9280');

insert into cliente values(157,'Paulo','Trav. Moraes, casa 3','Londrina',null,'PR','32848223/324-2','1923');

insert into cliente values(180,'Livio','Av. Beira Mar, 1256','Florianopolis','30077500','SC','12736571/2347-4','1111');

insert into cliente values(260,'Susana','Rua Lopes Mandes, 12','Niteroi','30046500','RJ','21763571/232-9','2530');

insert into cliente values(290,'Renato','Rua Meireles, 123','Sao Paulo','30225900','SP','13276571/1231-4','1820');

insert into cliente values(390,'Sebastiao','Rua da Igreja, 10','Uberaba','30438700','MG','32176547/213-3','9071');

insert into cliente values(234,'Jose','Quadra 3, Bl. 3, sl. 1003','Brasilia','22841650','DF','21763576/1232-3','2931');

commit;

insert into vendedor values(209,'Jose','1800','C');

insert into vendedor values(111,'Carlos','2490','A');

insert into vendedor values(11,'Joao','2780','C');

insert into vendedor values(240,'Antonio','9500','C');

insert into vendedor values(720,'Felipe','4600','A');

insert into vendedor values(213,'Jonas','2300','A');

insert into vendedor values(101,'Joao','2650','C');

insert into vendedor values(310,'Josias','870','B');

insert into vendedor values(250,'Mauricio','2930','B');

commit;

insert into produto values ('25','3','KG','Queijo','0.97');

insert into produto values ('31','6','BAR','Chocolate','0.87');

insert into produto values ('78','12','L','Vinho','2.00');

insert into produto values ('22','23','M','Linho','0.11');

insert into produto values ('30','5','SAC','Acucar','0.30');

insert into produto values ('53','10','M','Linha','1.80');

insert into produto values ('13','9','G','Ouro','6.18');

insert into produto values ('45','7','M','Madeira','0.25');

insert into produto values ('87','15','M','Cano','1.97');

insert into produto values ('77','24','M','Papel','1.05');

commit;

insert into pedido values ('121','20','410','209');

insert into pedido values ('97','20','720','101');

insert into pedido values ('101','15','720','101');

insert into pedido values ('137','20','720','720');

insert into pedido values ('148','20','720','101');

insert into pedido values ('189','15','870','213');

insert into pedido values ('104','30','110','101');

insert into pedido values ('203','30','830','250');

insert into pedido values ('98','20','410','209');

insert into pedido values ('143','30','20','11');

insert into pedido values ('105','30','180','240');

insert into pedido values ('111','15','260','240');

insert into pedido values ('103','20','260','11');

insert into pedido values ('91','20','260','11');

insert into pedido values ('138','20','260','11');

insert into pedido values ('108','15','290','310');

insert into pedido values ('119','30','390','250');

commit;

insert into item_pedido values ('121','25','10');

insert into item_pedido values ('121','31','35');

insert into item_pedido values ('97','77','20');

insert into item_pedido values ('101','31','9');

insert into item_pedido values ('101','78','18');

insert into item_pedido values ('101','13','5');

insert into item_pedido values ('98','77','5');

insert into item_pedido values ('148','45','8');

insert into item_pedido values ('148','31','7');

insert into item_pedido values ('148','77','3');

insert into item_pedido values ('148','25','10');

insert into item_pedido values ('148','78','30');

insert into item_pedido values ('104','53','32');

insert into item_pedido values ('203','31','6');

insert into item_pedido values ('189','78','45');

insert into item_pedido values ('143','31','20');

insert into item_pedido values ('143','78','10');

commit;

// -------------- PROCEDURES

create or replace procedure criar_pedido(
    p_num_pedido in number,
    p_pr_entrega in number,
    p_cod_clie in number,
    p_cod_ven in number,
    p_cod_prod in number,
    p_quant in number
) as
    v_qtd_disponivel number;
begin
    select qtd_prod
    into v_qtd_disponivel
    from produto
    where cod_prod = p_cod_prod;

    if v_qtd_disponivel < p_quant then
        dbms_output.put_line('erro: quantidade em estoque insuficiente.');
        return;
    end if;

    insert into pedido (num_pedido, pr_entrega, cod_clie, cod_ven)
    values (p_num_pedido, p_pr_entrega, p_cod_clie, p_cod_ven);

    insert into item_pedido (num_pedido, cod_prod, quant)
    values (p_num_pedido, p_cod_prod, p_quant);

    update produto
    set qtd_prod = qtd_prod - p_quant
    where cod_prod = p_cod_prod;

    dbms_output.put_line('pedido e item inseridos com sucesso.');
exception
    when no_data_found then
        dbms_output.put_line('erro: produto não encontrado.');
    when others then
        dbms_output.put_line('erro ao criar pedido: ' || sqlerrm);
end;

--------------------------------------------------------------------------------

create or replace procedure cancelar_pedido(
    p_num_pedido in number
) as
begin
    delete from item_pedido where num_pedido = p_num_pedido;
    delete from pedido where num_pedido = p_num_pedido;

    dbms_output.put_line('pedido cancelado com sucesso.');
exception
    when others then
        dbms_output.put_line('erro ao cancelar pedido: ' || sqlerrm);
end;
--------------------------------------------------------------------------------

create or replace procedure listar_itens_pedido(
    p_num_pedido in number) 
    as
    v_result varchar2(4000) := '';
begin
    for item in (
        select p.descricao, ip.quant, p.val_unit
        from item_pedido ip
        inner join produto p on ip.cod_prod = p.cod_prod
        where ip.num_pedido = p_num_pedido
    ) loop
        v_result := v_result || 'produto: ' || item.descricao ||
                     ', qtd: ' || item.quant ||
                     ', preco unit: r$ ' || item.val_unit || chr(10);
    end loop;

    DBMS_OUTPUT.PUT_LINE(v_result);
end;

begin
    listar_itens_pedido(121);
end;


begin
    criar_pedido(
        p_num_pedido => 999,
        p_pr_entrega => 10,
        p_cod_clie   => 720,
        p_cod_ven    => 101,
        p_cod_prod   => 31,    
        p_quant      => 2
    );
end;


begin
    listar_itens_pedido(999);
end;
--------------------------------------------------------------------------------

create or replace procedure listar_clientes_uf(p_uf in varchar2)
as 
    v_result varchar2(4000) := '';
begin
    for cliente in (
        select c.cod_clie, c.nome_clie, c.endereco, c.cidade, c.cep, c.uf 
        from cliente c 
        where c.uf = p_uf
    ) loop
        v_result := v_result || 'cod cliente: ' || cliente.cod_clie || ', nome cliente: ' || cliente.nome_clie ||
                    ' endereço: ' || cliente.endereco || ', cidade: ' || cliente.cidade || ', cep: ' || cliente.cep || ', uf: ' || cliente.uf || chr(10);
    end loop;

    dbms_output.put_line(v_result);
end;
/

begin
    listar_clientes_uf('RJ');
end;
/

--------------------------------------------------------------------------------

create or replace procedure listar_clientes_com_mais_pedidos_por_uf(p_uf in varchar2)
as 
    v_result varchar2(4000) := '';
begin
    for cliente in (
        select c.cod_clie, c.nome_clie, count(p.num_pedido) as quantidade_pedidos 
        from cliente c 
        inner join pedido p on c.cod_clie = p.cod_clie 
        where c.uf = p_uf  
        group by c.cod_clie, c.nome_clie 
        order by count(p.num_pedido) desc 
        fetch first 5 rows only
    ) loop
        v_result := v_result || 'cod cliente: ' || cliente.cod_clie || ', nome cliente: ' || cliente.nome_clie ||
                    ' numero de pedidos: ' || cliente.quantidade_pedidos || chr(10);
    end loop;

    dbms_output.put_line(v_result);
end;
/

begin
    listar_clientes_com_mais_pedidos_por_uf('RJ');
end;
/

--------------------------------------------------------------------------------

create or replace procedure listar_vendedores_que_mais_venderam
as 
    v_result varchar2(4000) := '';
begin
    for vende in (
        select v.cod_ven, v.nome_ven, count(p.num_pedido) as quantidade_pedidos, v.salario_fixo 
        from vendedor v 
        inner join pedido p on v.cod_ven = p.cod_ven   
        group by v.cod_ven, v.nome_ven, v.salario_fixo 
        order by count(p.num_pedido) desc 
        fetch first 5 rows only
    ) loop
        v_result := v_result || 'cod vendedor: ' || vende.cod_ven || ', nome vendedor: ' || vende.nome_ven ||
                    ' numero de pedidos: ' || vende.quantidade_pedidos || ' salario fixo: ' || vende.salario_fixo || chr(10);
    end loop;

    dbms_output.put_line(v_result);
end;
/

begin
    listar_vendedores_que_mais_venderam();
end;
/

--------------------------------------------------------------------------------

create or replace procedure listar_clientes_atendidos_pelo_vendedor(p_cod_ven in int)
as 
    v_result varchar2(4000);
    v_nome varchar2(200);
    v_cod int;
    v_tem_cliente boolean := false;
begin
    select cod_ven, nome_ven 
    into v_cod, v_nome 
    from vendedor 
    where cod_ven = p_cod_ven;

    dbms_output.put_line('codigo do vendedor: ' || v_cod || ', nome: ' || v_nome);

    for cliente in (
        select c.cod_clie, c.nome_clie 
        from cliente c 
        inner join pedido p on c.cod_clie = p.cod_clie 
        inner join vendedor v on p.cod_ven = v.cod_ven 
        where v.cod_ven = p_cod_ven
    ) loop
        v_tem_cliente := true;
        v_result := 'cod cliente: ' || cliente.cod_clie || ' nome cliente: ' || cliente.nome_clie;
        dbms_output.put_line(v_result);
    end loop;
    
    if not v_tem_cliente then
        dbms_output.put_line('nenhum cliente registrado para este vendedor.');
    end if;
exception 
    when no_data_found then
        dbms_output.put_line('nenhum vendedor encontrado com este id');
end;
/

begin
    listar_clientes_atendidos_pelo_vendedor(250);
end;
/

--------------------------------------------------------------------------------

create or replace procedure listar_produtos
as
begin
    dbms_output.put_line('lista de produtos:');
    
    for p in (
        select cod_prod, descricao, unidade, val_unit
        from produto
        order by descricao
    ) loop
        dbms_output.put_line('código: ' || p.cod_prod || 
                             ' | descrição: ' || p.descricao || 
                             ' | unidade: ' || p.unidade || 
                             ' | valor unitário: r$ ' || p.val_unit);
    end loop;
    
    if sql%rowcount = 0 then
        dbms_output.put_line('nenhum produto registrado.');
    end if;
end;
/

begin
    listar_produtos;
end;
/

--------------------------------------------------------------------------------

create or replace procedure atualizar_valor_produto(
    p_cod_prod in produto.cod_prod%type,
    p_novo_valor in produto.val_unit%type
)
as
begin
    update produto
    set val_unit = p_novo_valor
    where cod_prod = p_cod_prod;

    if sql%rowcount = 0 then
        dbms_output.put_line('produto nao encontrado.');
    else
        dbms_output.put_line('produto ' || p_cod_prod || 
                             ' atualizado para r$ ' || to_char(p_novo_valor));
    end if;

    commit;
end;
/

begin
    atualizar_valor_produto(30, to_number('1.5', '9999.99'));
end;
/

--------------------------------------------------------------------------------

create or replace procedure adicionar_item_pedido (
    p_num_pedido in item_pedido.num_pedido%type,
    p_cod_prod   in item_pedido.cod_prod%type,
    p_quant      in item_pedido.quant%type
) as
    v_qtd_disponivel produto.qtd_prod%type;
begin
    select qtd_prod into v_qtd_disponivel
    from produto
    where cod_prod = p_cod_prod;

    if v_qtd_disponivel < p_quant then
        dbms_output.put_line('erro: quantidade em estoque insuficiente.');
        return;
    end if;

    insert into item_pedido (num_pedido, cod_prod, quant)
    values (p_num_pedido, p_cod_prod, p_quant);

    update produto
    set qtd_prod = qtd_prod - p_quant
    where cod_prod = p_cod_prod;

    dbms_output.put_line('item adicionado com sucesso.');
exception
    when no_data_found then
        dbms_output.put_line('erro: produto não encontrado.');
    when others then
        dbms_output.put_line('erro ao adicionar item: ' || sqlerrm);
end;
/

begin
    adicionar_item_pedido(999, 25, 3);
end;
/

--------------------------------------------------------------------------------

create or replace procedure remover_item_pedido (
    p_num_pedido in item_pedido.num_pedido%type,
    p_cod_prod   in item_pedido.cod_prod%type
) as
    v_quantidade_removida item_pedido.quant%type;
begin
    select quant into v_quantidade_removida
    from item_pedido
    where num_pedido = p_num_pedido and cod_prod = p_cod_prod;

    delete from item_pedido
    where num_pedido = p_num_pedido and cod_prod = p_cod_prod;

    update produto
    set qtd_prod = qtd_prod + v_quantidade_removida
    where cod_prod = p_cod_prod;

    dbms_output.put_line('item removido com sucesso.');
exception
    when no_data_found then
        dbms_output.put_line('erro: item não encontrado.');
    when others then
        dbms_output.put_line('erro ao remover item: ' || sqlerrm);
end;
/

begin
    remover_item_pedido(999, 25);
end;
/


// -------------- FUNCOES

create or replace function fn_obter_nome_cliente(p_cod_clie in number)
return varchar2
is
    v_nome_cliente cliente.nome_clie%type;
begin
    select nome_clie into v_nome_cliente
    from cliente
    where cod_clie = p_cod_clie;
    
    return v_nome_cliente;
exception
    when no_data_found then
        return 'cliente não encontrado';
end;
/

select fn_obter_nome_cliente(720) as nome_cliente from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_total_pedidos_cliente(p_cod_clie in number)
return number
is
    v_total number := 0;
begin
    select count(*) into v_total
    from pedido
    where cod_clie = p_cod_clie;

    return v_total;
end;
/

select fn_total_pedidos_cliente(720) as total_pedidos from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_nome_vendedor(p_cod_ven in number)
return varchar2
is
    v_nome vendedor.nome_ven%type;
begin
    select nome_ven into v_nome
    from vendedor
    where cod_ven = p_cod_ven;

    return v_nome;
exception
    when no_data_found then
        return 'vendedor não encontrado';
end;
/

select fn_nome_vendedor(101) as nome_vendedor from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_qtd_pedidos_vendedor(p_cod_ven in number)
return number
is
    v_total number := 0;
begin
    select count(*) into v_total
    from pedido
    where cod_ven = p_cod_ven;

    return v_total;
end;
/

select fn_qtd_pedidos_vendedor(101) as qtd_pedidos from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_nome_produto(p_cod_prod in number)
return varchar2
is
    v_desc produto.descricao%type;
begin
    select descricao into v_desc
    from produto
    where cod_prod = p_cod_prod;

    return v_desc;
exception
    when no_data_found then
        return 'produto não encontrado';
end;
/

select fn_nome_produto(31) as nome_produto from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_estoque_disponivel(p_cod_prod in number)
return number
is
    v_qtd produto.qtd_prod%type := 0;
begin
    select qtd_prod into v_qtd
    from produto
    where cod_prod = p_cod_prod;

    return v_qtd;
exception
    when no_data_found then
        return -1;
end;
/

select fn_estoque_disponivel(31) as estoque from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_prazo_entrega(p_num_pedido in number)
return number
is
    v_prazo pedido.pr_entrega%type;
begin
    select pr_entrega into v_prazo
    from pedido
    where num_pedido = p_num_pedido;

    return v_prazo;
exception
    when no_data_found then
        return null;
end;
/

select fn_prazo_entrega(999) as prazo_entrega from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_cliente_do_pedido(p_num_pedido in number)
return varchar2
is
    v_nome_cliente cliente.nome_clie%type;
begin
    select c.nome_clie into v_nome_cliente
    from pedido p
    join cliente c on p.cod_clie = c.cod_clie
    where p.num_pedido = p_num_pedido;

    return v_nome_cliente;
exception
    when no_data_found then
        return 'pedido não encontrado';
end;
/

select fn_cliente_do_pedido(999) as cliente_pedido from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_qtd_item_pedido(p_num_pedido in number, p_cod_prod in number)
return number
is
    v_quant item_pedido.quant%type;
begin
    select quant into v_quant
    from item_pedido
    where num_pedido = p_num_pedido and cod_prod = p_cod_prod;

    return v_quant;
exception
    when no_data_found then
        return 0;
end;
/

select fn_qtd_item_pedido(999, 31) as quantidade_item from dual;
/

--------------------------------------------------------------------------------

create or replace function fn_total_item_pedido(p_num_pedido in number, p_cod_prod in number)
return number
is
    v_total number := 0;
begin
    select ip.quant * p.val_unit into v_total
    from item_pedido ip
    join produto p on ip.cod_prod = p.cod_prod
    where ip.num_pedido = p_num_pedido and ip.cod_prod = p_cod_prod;

    return v_total;
exception
    when no_data_found then
        return 0;
end;
/

select fn_total_item_pedido(999, 31) as total_item from dual;
/








