
/* Creacion de BBDD*/

CREATE DATABASE GD1C2021ENTREGA

/* Creacion de Schema*/
USE GD1C2021ENTREGA
go
--CREATE SCHEMA FJGD AUTHORIZATION dbo


/* Creacion de Tablas */

USE GD1C2021ENTREGA
GO
CREATE PROCEDURE [FJGD].[CreacionDeTablas] 
AS

CREATE TABLE [FJGD].Cliente(--1
	clie_DNI char(15) NOT NULL,
	clie_Apellido char(30) NOT NULL,
	clie_Nombre char(30) NOT NULL,
	clie_Direccion char(50) NULL,
	clie_fechaNacimiento smalldatetime NULL,
	clie_mail char(50) NULL,
	clie_telefono char(50) NULL
)
--2
CREATE TABLE [FJGD].Factura(
	fact_Numero decimal(18, 0) NOT NULL,
	fact_idCliente char(15) NULL, -- TODO: Cambiar x 'NOT NULL'
	fact_fecha smalldatetime NOT NULL,
	fact_Total decimal(14,2) NOT NULL
)
--3
CREATE TABLE [FJGD].ItemFactura(
	ifact_FacturaNumero decimal(18, 0) NOT NULL,
	ifact_idProducto char(15) NOT NULL,
	ifact_idCategoria int NOT NULL,
	ifact_Cantidad decimal(10,2) NOT NULL,
	ifact_PrecioProducto decimal(14,2) NOT NULL
)
--4
CREATE TABLE [FJGD].Compra(
	comp_NumeroCompra char(15) NOT NULL,
	comp_idSucursal int NOT NULL,
	comp_FechaCompra smalldatetime NOT NULL,
	comp_GastoTotal decimal(14,2) NOT NULL
)
--5
CREATE TABLE [FJGD].ItemCompra(
	icomp_idCompra char(15) NOT NULL,
	icomp_idProducto char(15) NOT NULL,
	icomp_idCategoria int NOT NULL,
	icomp_PrecioCompra decimal(14,2) NOT NULL,
	icomp_Cantidad decimal(10,2)
)
--6
CREATE TABLE [FJGD].Sucursal(
	sucu_idSucursal int IDENTITY(1,1)  NOT NULL,
	sucu_Mail char(50) NULL,
	sucu_Direccion char(50) NOT NULL,
	sucu_Telefono decimal(18, 0) NULL,
	sucu_Ciudad char(50) NULL
)
--7
CREATE TABLE [FJGD].Stock(
	stoc_idStock int NOT NULL,
	stoc_idSucursal int NOT NULL,
	stoc_idCategoria int NOT NULL,
	stoc_idProducto char(15) NOT NULL,
	stoc_Cantidad decimal(10,2)
)
--8
CREATE TABLE [FJGD].Producto(
	prod_codProducto char(15) NOT NULL,
	prod_idCategoria int NOT NULL,
	prod_Decripcion char(50) NULL,
	prod_Precio decimal(14,2) NOT NULL
)
--9
CREATE TABLE [FJGD].Categoria(
	cate_idCategoria int NOT NULL,
	cate_Descripcion  char(15) NOT NULL
)
--10
CREATE TABLE [FJGD].Accesorio(
	acce_idCodigo char(15) NOT NULL,
	acce_Descripcion char(50) NULL
)
--11
CREATE TABLE [FJGD].PC(
	pc_idCodigo char(15) NOT NULL,
	pc_alto char(15) NOT NULL,
	pc_ancho char(15) NOT NULL,
	pc_profundida char(15) NOT NULL,
	pc_idRam char(15) NOT NULL,
	pc_idMicro char(15) NOT NULL,
	pc_idVideo char(15) NOT NULL,
	pc_idDisco char(15) NOT NULL
)
--12
CREATE TABLE [FJGD].Fabricante(
	fabr_codigo char(30) NOT NULL
)
--13
CREATE TABLE [FJGD].RAM(
	ram_idRam char(15) NOT NULL,
	ram_Tipo char(20) NOT NULL,
	ram_Capacidad char(30) NOT NULL,
	ram_Velocidad char(30) NOT NULL,
	ram_idFabricante char(30) NOT NULL
)
--14
CREATE TABLE [FJGD].Micro(
	micr_idMicro char(15) NOT NULL,
	micr_Cache char(20) NOT NULL,
	micr_CantHilos char(5) NOT NULL,
	micr_Velocidad char(30) NOT NULL,
	micr_idFabricante char(30) NOT NULL
)
--15
CREATE TABLE [FJGD].Video(
	vide_Chipset char(30) NOT NULL,
	vide_Capacidad char(30) NOT NULL,
	vide_Velocidad char(30) NOT NULL,
	vide_Modelo char(15) NOT NULL,
	vide_idFabricante char(30) NOT NULL
)
--16
CREATE TABLE [FJGD].Disco(
	disc_idDisco char(15) NOT NULL,
	disc_tipo char(30) NOT NULL,
	disc_capacidad char(30) NOT NULL,
	disc_velocidad char(30) NOT NULL,
	disc_idFabricante  char(30) NOT NULL
)
go