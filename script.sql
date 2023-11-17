create database ByteGuard;
use ByteGuard;
create table Log (
    idLog int primary key auto_increment,
    textLog varchar(45),
    valor double,
    dataLog datetime,
    statusLog tinyint
);