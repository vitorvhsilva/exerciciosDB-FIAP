REM   Script: nosso_sistema
REM   gtkojorthjoijurth
set serveroutput on
set verify off

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
/

create or replace function calcular_total_pedido(
    p_num_pedido in number
) return number is
    v_total number := 0;
begin
    select sum(ip.quant * p.val_unit)
    into v_total
    from item_pedido ip
    inner join produto p on ip.cod_prod = p.cod_prod
    where ip.num_pedido = p_num_pedido;

    return v_total;
exception
    when no_data_found then
        return 0;
    when others then
        dbms_output.put_line('erro ao calcular total: ' || sqlerrm);
        return -1;
end;
/

create or replace function listar_itens_pedido(
    p_num_pedido in number
) return varchar2 is
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

    return v_result;
end;
/

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
/

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
/

begin
    dbms_output.put_line(listar_itens_pedido(999));
end;
/

select calcular_total_pedido(999) as total_pedido from dual;
