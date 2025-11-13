DROP DATABASE IF EXISTS PoliSongStockMarketPlacePA;
CREATE DATABASE PoliSongStockMarketPlacePA;
USE PoliSongStockMarketPlacePA;


CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    tipo_usuario VARCHAR (30) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    direccion VARCHAR(255),
    password VARCHAR(255) NOT NULL,
);


CREATE TABLE lista_reproduccion (
    id_lista INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_usuario INT NOT NULL,
    publica enum("si","no"),
    fecha_creacion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE autor (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    edad INT,
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

CREATE TABLE cancion (
    id_cancion INT PRIMARY KEY AUTO_INCREMENT,
    id_autor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    genero VARCHAR(100),
    duracion VARCHAR(10),
    tamano_mb DECIMAL(5,2),
    calidad_kbps INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

CREATE TABLE canciones_lista (
 id_lista int not null,
    id_cancion int not null,
    primary key (id_lista, id_cancion),
    foreign key (id_lista) references lista_reproduccion(id_lista),
    foreign key (id_cancion) references cancion(id_cancion)
    );

CREATE TABLE disco_mp3 (
    id_disco_mp3 INT PRIMARY KEY AUTO_INCREMENT,
    id_autor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    genero VARCHAR(100),
    precio DECIMAL(10,2),
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);


CREATE TABLE cancion_disco_mp3 (
    id_cancion INT NOT NULL,
    id_disco_mp3 INT NOT NULL,
    PRIMARY KEY (id_cancion, id_disco_mp3),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion),
    FOREIGN KEY (id_disco_mp3) REFERENCES disco_mp3(id_disco_mp3)
);


CREATE TABLE disco_vinilo (
    id_disco_vinilo INT PRIMARY KEY AUTO_INCREMENT,
    id_autor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    anio_salida YEAR,
    precio DECIMAL(10,2),
    cantidad INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

CREATE TABLE cancion_vinilo (
    id_cancion INT NOT NULL,
    id_disco_vinilo INT NOT NULL,
    PRIMARY KEY (id_cancion, id_disco_vinilo),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion),
    FOREIGN KEY (id_disco_vinilo) REFERENCES disco_vinilo(id_disco_vinilo)
);


CREATE TABLE venta (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_disco_vinilo INT,
    id_disco_mp3 INT,
    cantidad INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente','aceptada','rechazada','enviada','recibida'),
    observacion VARCHAR(255),
    metodo_pago ENUM('TarjetaCredito','TarjetaDebito','PayPal','Otro'),
    fecha_envio DATETIME,
    fecha_recepcion DATETIME,
    valoracion TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_disco_vinilo) REFERENCES disco_vinilo(id_disco_vinilo),
    FOREIGN KEY (id_disco_mp3) REFERENCES disco_mp3(id_disco_mp3)
);


CREATE TABLE historial_venta (
    id_historial_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL,
    numero_ventas INT,
    fecha_hora DATETIME,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);


CREATE TABLE envio (
    id_envio INT PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL,
    fecha_envio DATETIME,
    estado_envio ENUM('En preparación','Enviado','En tránsito','Entregado','Retrasado'),
    codigo_seguimiento VARCHAR(100),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
);


CREATE TABLE reporte_ventas (
    id_reporte INT PRIMARY KEY AUTO_INCREMENT,
    fecha_inicio DATE,
    fecha_fin DATE,
    total_ventas INT,
    total_ingresos DECIMAL(15,2),
    estado_reporte ENUM('Abierto','Cerrado'),
    venta_id_venta INT,
    FOREIGN KEY (venta_id_venta) REFERENCES venta(id_venta)
);
