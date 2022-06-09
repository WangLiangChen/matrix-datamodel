/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     2022/5/21 12:07:43                           */
/*==============================================================*/


drop index self_FK;

drop index authorization_group_PK;

drop table authorization_group;

drop index group_subject_subject_FK;

drop index group_subject_group_FK;

drop index authorization_group_subject_PK;

drop table authorization_group_subject;

drop index resource_operation_FK;

drop index authorization_operation_PK;

drop table authorization_operation;

drop index operation_permission_FK;

drop index authorization_permission_PK;

drop table authorization_permission;

drop index self_FK2;

drop index authorization_resource_PK;

drop table authorization_resource;

drop index authorization_role_PK;

drop table authorization_role;

drop index role_operation_operation_FK;

drop index role_operation_role_FK;

drop index authorization_role_resource_operation_PK;

drop table authorization_role_resource_operation;

drop index role_subject_subject_FK;

drop index role_subject_role_FK;

drop index authorization_role_subject_PK;

drop table authorization_role_subject;

drop index authorization_rolegroup_PK;

drop table authorization_rolegroup;

drop index rolegroup_role_role_FK;

drop index rolegroup_role_rolegroup_FK;

drop index authorization_rolegroup_role_PK;

drop table authorization_rolegroup_role;

drop index rolegroup_subject_subject_FK;

drop index rolegroup_subject_rolegroup_FK;

drop index authorization_rolegroup_subject_PK;

drop table authorization_rolegroup_subject;

drop index authorization_subject_PK;

drop table authorization_subject;

drop index extended_column_FK;

drop index authorization_subject_extended_column_PK;

drop table authorization_subject_extended_column;

/*==============================================================*/
/* Table: authorization_group                                   */
/*==============================================================*/
create table authorization_group (
   group_id             INT8                 not null,
   parent_id            INT8                 null,
   tenant_code          VARCHAR(36)          not null,
   app_code             VARCHAR(36)          not null,
   group_code           VARCHAR(36)          not null,
   group_name           VARCHAR(36)          not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_GROUP primary key (group_id)
);

comment on table authorization_group is
'被授权主体所属的组,用于类似组织机构的属性';

comment on column authorization_group.group_id is
'PrimaryKey';

comment on column authorization_group.parent_id is
'PrimaryKey';

comment on column authorization_group.group_code is
'标识';

comment on column authorization_group.group_name is
'名称';

comment on column authorization_group.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_group.version is
'版本号,可用于乐观锁';

comment on column authorization_group.sort is
'默认排序';

comment on column authorization_group.owner is
'属主标识';

comment on column authorization_group.creator is
'创建者标识';

comment on column authorization_group.create_datetime is
'创建时间,长度6';

comment on column authorization_group.modifier is
'最后修改者标识';

comment on column authorization_group.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_group.summary is
'简述说明';

comment on column authorization_group.state is
'状态';

/*==============================================================*/
/* Index: authorization_group_PK                                */
/*==============================================================*/
create unique index authorization_group_PK on authorization_group (
group_id
);

/*==============================================================*/
/* Index: self_FK                                               */
/*==============================================================*/
create  index self_FK on authorization_group (
parent_id
);

/*==============================================================*/
/* Table: authorization_group_subject                           */
/*==============================================================*/
create table authorization_group_subject (
   group_id             INT8                 not null,
   subject_id           INT8                 not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_GROUP_SUBJECT primary key (group_id, subject_id)
);

comment on table authorization_group_subject is
'组 主体关系';

comment on column authorization_group_subject.group_id is
'PrimaryKey';

comment on column authorization_group_subject.subject_id is
'PrimaryKey';

comment on column authorization_group_subject.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_group_subject.version is
'版本号,可用于乐观锁';

comment on column authorization_group_subject.sort is
'默认排序';

comment on column authorization_group_subject.owner is
'属主标识';

comment on column authorization_group_subject.creator is
'创建者标识';

comment on column authorization_group_subject.create_datetime is
'创建时间,长度6';

comment on column authorization_group_subject.modifier is
'最后修改者标识';

comment on column authorization_group_subject.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_group_subject.summary is
'简述说明';

comment on column authorization_group_subject.state is
'状态';

/*==============================================================*/
/* Index: authorization_group_subject_PK                        */
/*==============================================================*/
create unique index authorization_group_subject_PK on authorization_group_subject (
group_id,
subject_id
);

/*==============================================================*/
/* Index: group_subject_group_FK                                */
/*==============================================================*/
create  index group_subject_group_FK on authorization_group_subject (
group_id
);

/*==============================================================*/
/* Index: group_subject_subject_FK                              */
/*==============================================================*/
create  index group_subject_subject_FK on authorization_group_subject (
subject_id
);

/*==============================================================*/
/* Table: authorization_operation                               */
/*==============================================================*/
create table authorization_operation (
   resource_id          INT8                 not null,
   operation_id         INT8                 not null,
   operation_code       VARCHAR(36)          not null,
   operation_name       VARCHAR(36)          not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_OPERATION primary key (resource_id, operation_id)
);

comment on table authorization_operation is
'被授权资源的操作,定义对指定资源的CRUD等操作.';

comment on column authorization_operation.resource_id is
'PrimaryKey';

comment on column authorization_operation.operation_id is
'Primarykey';

comment on column authorization_operation.operation_code is
'标识';

comment on column authorization_operation.operation_name is
'名称';

comment on column authorization_operation.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_operation.version is
'版本号,可用于乐观锁';

comment on column authorization_operation.sort is
'默认排序';

comment on column authorization_operation.owner is
'属主标识';

comment on column authorization_operation.creator is
'创建者标识';

comment on column authorization_operation.create_datetime is
'创建时间,长度6';

comment on column authorization_operation.modifier is
'最后修改者标识';

comment on column authorization_operation.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_operation.summary is
'简述说明';

comment on column authorization_operation.state is
'状态';

/*==============================================================*/
/* Index: authorization_operation_PK                            */
/*==============================================================*/
create unique index authorization_operation_PK on authorization_operation (
resource_id,
operation_id
);

/*==============================================================*/
/* Index: resource_operation_FK                                 */
/*==============================================================*/
create  index resource_operation_FK on authorization_operation (
resource_id
);

/*==============================================================*/
/* Table: authorization_permission                              */
/*==============================================================*/
create table authorization_permission (
   resource_id          INT8                 not null,
   operation_id         INT8                 not null,
   permission_id        INT8                 not null,
   permission_uri       VARCHAR(200)         not null,
   permission_label     VARCHAR(200)         not null,
   permission_rule      VARCHAR(200)         not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_PERMISSION primary key (resource_id, operation_id, permission_id)
);

comment on table authorization_permission is
'被授权资源操作对应的权限
uri
label
rule';

comment on column authorization_permission.resource_id is
'PrimaryKey';

comment on column authorization_permission.operation_id is
'Primarykey';

comment on column authorization_permission.permission_id is
'PrimaryKey';

comment on column authorization_permission.permission_uri is
'[{"method":"PUT","ant_path":"/account/*"}]';

comment on column authorization_permission.permission_label is
'[{"k":"","v":}]';

comment on column authorization_permission.permission_rule is
'SPEL ';

comment on column authorization_permission.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_permission.version is
'版本号,可用于乐观锁';

comment on column authorization_permission.sort is
'默认排序';

comment on column authorization_permission.owner is
'属主标识';

comment on column authorization_permission.creator is
'创建者标识';

comment on column authorization_permission.create_datetime is
'创建时间,长度6';

comment on column authorization_permission.modifier is
'最后修改者标识';

comment on column authorization_permission.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_permission.summary is
'简述说明';

comment on column authorization_permission.state is
'状态';

/*==============================================================*/
/* Index: authorization_permission_PK                           */
/*==============================================================*/
create unique index authorization_permission_PK on authorization_permission (
resource_id,
operation_id,
permission_id
);

/*==============================================================*/
/* Index: operation_permission_FK                               */
/*==============================================================*/
create  index operation_permission_FK on authorization_permission (
resource_id,
operation_id
);

/*==============================================================*/
/* Table: authorization_resource                                */
/*==============================================================*/
create table authorization_resource (
   resource_id          INT8                 not null,
   parent_id            INT8                 null,
   tenant_code          VARCHAR(36)          not null,
   app_code             VARCHAR(36)          not null,
   resource_code        VARCHAR(36)          not null,
   resource_name        VARCHAR(36)          not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_RESOURCE primary key (resource_id)
);

comment on table authorization_resource is
'被授权的资源,资源的定义可以参照RESTful的资源';

comment on column authorization_resource.resource_id is
'PrimaryKey';

comment on column authorization_resource.parent_id is
'PrimaryKey';

comment on column authorization_resource.resource_code is
'标识';

comment on column authorization_resource.resource_name is
'名称';

comment on column authorization_resource.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_resource.version is
'版本号,可用于乐观锁';

comment on column authorization_resource.sort is
'默认排序';

comment on column authorization_resource.owner is
'属主标识';

comment on column authorization_resource.creator is
'创建者标识';

comment on column authorization_resource.create_datetime is
'创建时间,长度6';

comment on column authorization_resource.modifier is
'最后修改者标识';

comment on column authorization_resource.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_resource.summary is
'简述说明';

comment on column authorization_resource.state is
'状态';

/*==============================================================*/
/* Index: authorization_resource_PK                             */
/*==============================================================*/
create unique index authorization_resource_PK on authorization_resource (
resource_id
);

/*==============================================================*/
/* Index: self_FK2                                              */
/*==============================================================*/
create  index self_FK2 on authorization_resource (
parent_id
);

/*==============================================================*/
/* Table: authorization_role                                    */
/*==============================================================*/
create table authorization_role (
   role_id              INT8                 not null,
   tenant_code          VARCHAR(36)          not null,
   app_code             VARCHAR(36)          not null,
   role_code            VARCHAR(36)          not null,
   role_name            VARCHAR(36)          not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_ROLE primary key (role_id)
);

comment on table authorization_role is
'被授权主体所属的角色';

comment on column authorization_role.role_id is
'PrimaryKey';

comment on column authorization_role.role_code is
'标识';

comment on column authorization_role.role_name is
'名称';

comment on column authorization_role.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_role.version is
'版本号,可用于乐观锁';

comment on column authorization_role.sort is
'默认排序';

comment on column authorization_role.owner is
'属主标识';

comment on column authorization_role.creator is
'创建者标识';

comment on column authorization_role.create_datetime is
'创建时间,长度6';

comment on column authorization_role.modifier is
'最后修改者标识';

comment on column authorization_role.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_role.summary is
'简述说明';

comment on column authorization_role.state is
'状态';

/*==============================================================*/
/* Index: authorization_role_PK                                 */
/*==============================================================*/
create unique index authorization_role_PK on authorization_role (
role_id
);

/*==============================================================*/
/* Table: authorization_role_resource_operation                 */
/*==============================================================*/
create table authorization_role_resource_operation (
   role_id              INT8                 not null,
   resource_id          INT8                 not null,
   operation_id         INT8                 not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_ROLE_RESOURCE primary key (resource_id, role_id, operation_id)
);

comment on column authorization_role_resource_operation.role_id is
'PrimaryKey';

comment on column authorization_role_resource_operation.resource_id is
'PrimaryKey';

comment on column authorization_role_resource_operation.operation_id is
'Primarykey';

comment on column authorization_role_resource_operation.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_role_resource_operation.version is
'版本号,可用于乐观锁';

comment on column authorization_role_resource_operation.sort is
'默认排序';

comment on column authorization_role_resource_operation.owner is
'属主标识';

comment on column authorization_role_resource_operation.creator is
'创建者标识';

comment on column authorization_role_resource_operation.create_datetime is
'创建时间,长度6';

comment on column authorization_role_resource_operation.modifier is
'最后修改者标识';

comment on column authorization_role_resource_operation.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_role_resource_operation.summary is
'简述说明';

comment on column authorization_role_resource_operation.state is
'状态';

/*==============================================================*/
/* Index: authorization_role_resource_operation_PK              */
/*==============================================================*/
create unique index authorization_role_resource_operation_PK on authorization_role_resource_operation (
resource_id,
role_id,
operation_id
);

/*==============================================================*/
/* Index: role_operation_role_FK                                */
/*==============================================================*/
create  index role_operation_role_FK on authorization_role_resource_operation (
role_id
);

/*==============================================================*/
/* Index: role_operation_operation_FK                           */
/*==============================================================*/
create  index role_operation_operation_FK on authorization_role_resource_operation (
resource_id,
operation_id
);

/*==============================================================*/
/* Table: authorization_role_subject                            */
/*==============================================================*/
create table authorization_role_subject (
   role_id              INT8                 not null,
   subject_id           INT8                 not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_ROLE_SUBJECT primary key (role_id, subject_id)
);

comment on table authorization_role_subject is
'角色 主体关系';

comment on column authorization_role_subject.role_id is
'PrimaryKey';

comment on column authorization_role_subject.subject_id is
'PrimaryKey';

comment on column authorization_role_subject.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_role_subject.version is
'版本号,可用于乐观锁';

comment on column authorization_role_subject.sort is
'默认排序';

comment on column authorization_role_subject.owner is
'属主标识';

comment on column authorization_role_subject.creator is
'创建者标识';

comment on column authorization_role_subject.create_datetime is
'创建时间,长度6';

comment on column authorization_role_subject.modifier is
'最后修改者标识';

comment on column authorization_role_subject.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_role_subject.summary is
'简述说明';

comment on column authorization_role_subject.state is
'状态';

/*==============================================================*/
/* Index: authorization_role_subject_PK                         */
/*==============================================================*/
create unique index authorization_role_subject_PK on authorization_role_subject (
role_id,
subject_id
);

/*==============================================================*/
/* Index: role_subject_role_FK                                  */
/*==============================================================*/
create  index role_subject_role_FK on authorization_role_subject (
role_id
);

/*==============================================================*/
/* Index: role_subject_subject_FK                               */
/*==============================================================*/
create  index role_subject_subject_FK on authorization_role_subject (
subject_id
);

/*==============================================================*/
/* Table: authorization_rolegroup                               */
/*==============================================================*/
create table authorization_rolegroup (
   rolegroup_id         INT8                 not null,
   tenant_code          VARCHAR(36)          not null,
   app_code             VARCHAR(36)          not null,
   rolegroup_name       VARCHAR(36)          not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_ROLEGROUP primary key (rolegroup_id)
);

comment on table authorization_rolegroup is
'被授权主体所属的角色组';

comment on column authorization_rolegroup.rolegroup_id is
'PrimaryKey';

comment on column authorization_rolegroup.rolegroup_name is
'名称';

comment on column authorization_rolegroup.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_rolegroup.version is
'版本号,可用于乐观锁';

comment on column authorization_rolegroup.sort is
'默认排序';

comment on column authorization_rolegroup.owner is
'属主标识';

comment on column authorization_rolegroup.creator is
'创建者标识';

comment on column authorization_rolegroup.create_datetime is
'创建时间,长度6';

comment on column authorization_rolegroup.modifier is
'最后修改者标识';

comment on column authorization_rolegroup.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_rolegroup.summary is
'简述说明';

comment on column authorization_rolegroup.state is
'状态';

/*==============================================================*/
/* Index: authorization_rolegroup_PK                            */
/*==============================================================*/
create unique index authorization_rolegroup_PK on authorization_rolegroup (
rolegroup_id
);

/*==============================================================*/
/* Table: authorization_rolegroup_role                          */
/*==============================================================*/
create table authorization_rolegroup_role (
   rolegroup_id         INT8                 not null,
   role_id              INT8                 not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_ROLEGROUP_ROL primary key (rolegroup_id, role_id)
);

comment on table authorization_rolegroup_role is
'角色组 角色关系';

comment on column authorization_rolegroup_role.rolegroup_id is
'PrimaryKey';

comment on column authorization_rolegroup_role.role_id is
'PrimaryKey';

comment on column authorization_rolegroup_role.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_rolegroup_role.version is
'版本号,可用于乐观锁';

comment on column authorization_rolegroup_role.sort is
'默认排序';

comment on column authorization_rolegroup_role.owner is
'属主标识';

comment on column authorization_rolegroup_role.creator is
'创建者标识';

comment on column authorization_rolegroup_role.create_datetime is
'创建时间,长度6';

comment on column authorization_rolegroup_role.modifier is
'最后修改者标识';

comment on column authorization_rolegroup_role.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_rolegroup_role.summary is
'简述说明';

comment on column authorization_rolegroup_role.state is
'状态';

/*==============================================================*/
/* Index: authorization_rolegroup_role_PK                       */
/*==============================================================*/
create unique index authorization_rolegroup_role_PK on authorization_rolegroup_role (
rolegroup_id,
role_id
);

/*==============================================================*/
/* Index: rolegroup_role_rolegroup_FK                           */
/*==============================================================*/
create  index rolegroup_role_rolegroup_FK on authorization_rolegroup_role (
rolegroup_id
);

/*==============================================================*/
/* Index: rolegroup_role_role_FK                                */
/*==============================================================*/
create  index rolegroup_role_role_FK on authorization_rolegroup_role (
role_id
);

/*==============================================================*/
/* Table: authorization_rolegroup_subject                       */
/*==============================================================*/
create table authorization_rolegroup_subject (
   rolegroup_id         INT8                 not null,
   subject_id           INT8                 not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_ROLEGROUP_SUB primary key (rolegroup_id, subject_id)
);

comment on table authorization_rolegroup_subject is
'角色组 主体关系';

comment on column authorization_rolegroup_subject.rolegroup_id is
'PrimaryKey';

comment on column authorization_rolegroup_subject.subject_id is
'PrimaryKey';

comment on column authorization_rolegroup_subject.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_rolegroup_subject.version is
'版本号,可用于乐观锁';

comment on column authorization_rolegroup_subject.sort is
'默认排序';

comment on column authorization_rolegroup_subject.owner is
'属主标识';

comment on column authorization_rolegroup_subject.creator is
'创建者标识';

comment on column authorization_rolegroup_subject.create_datetime is
'创建时间,长度6';

comment on column authorization_rolegroup_subject.modifier is
'最后修改者标识';

comment on column authorization_rolegroup_subject.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_rolegroup_subject.summary is
'简述说明';

comment on column authorization_rolegroup_subject.state is
'状态';

/*==============================================================*/
/* Index: authorization_rolegroup_subject_PK                    */
/*==============================================================*/
create unique index authorization_rolegroup_subject_PK on authorization_rolegroup_subject (
rolegroup_id,
subject_id
);

/*==============================================================*/
/* Index: rolegroup_subject_rolegroup_FK                        */
/*==============================================================*/
create  index rolegroup_subject_rolegroup_FK on authorization_rolegroup_subject (
rolegroup_id
);

/*==============================================================*/
/* Index: rolegroup_subject_subject_FK                          */
/*==============================================================*/
create  index rolegroup_subject_subject_FK on authorization_rolegroup_subject (
subject_id
);

/*==============================================================*/
/* Table: authorization_subject                                 */
/*==============================================================*/
create table authorization_subject (
   subject_id           INT8                 not null,
   tenant_code          VARCHAR(36)          not null,
   app_code             VARCHAR(36)          not null,
   subject_code         VARCHAR(72)          not null,
   subject_name         VARCHAR(36)          not null,
   data_mode            INT2                 not null default 0,
   version              INT4                 not null default 0,
   sort                 INT4                 not null default 0,
   owner                VARCHAR(36)          not null default '',
   creator              VARCHAR(36)          not null default '',
   create_datetime      DATE                 not null,
   modifier             VARCHAR(36)          not null default '',
   modify_datetime      DATE                 not null,
   summary              VARCHAR(200)         not null default '',
   state                VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_SUBJECT primary key (subject_id)
);

comment on table authorization_subject is
'被授权的主体';

comment on column authorization_subject.subject_id is
'PrimaryKey';

comment on column authorization_subject.subject_code is
'标识,如账户名.注意:如账户来源于账户系统或认证系统,使用\组合来确保唯一.如 WEIXIN\LiangChenWang';

comment on column authorization_subject.subject_name is
'名称';

comment on column authorization_subject.data_mode is
'权限模式 4:Retrieve:2:Update;1:Delete;0:NONE;-1:ALL; ';

comment on column authorization_subject.version is
'版本号,可用于乐观锁';

comment on column authorization_subject.sort is
'默认排序';

comment on column authorization_subject.owner is
'属主标识';

comment on column authorization_subject.creator is
'创建者标识';

comment on column authorization_subject.create_datetime is
'创建时间,长度6';

comment on column authorization_subject.modifier is
'最后修改者标识';

comment on column authorization_subject.modify_datetime is
'最后修改时间,长度6';

comment on column authorization_subject.summary is
'简述说明';

comment on column authorization_subject.state is
'状态';

/*==============================================================*/
/* Index: authorization_subject_PK                              */
/*==============================================================*/
create unique index authorization_subject_PK on authorization_subject (
subject_id
);

/*==============================================================*/
/* Table: authorization_subject_extended_column                 */
/*==============================================================*/
create table authorization_subject_extended_column (
   subject_id           INT8                 not null,
   column_id            INT8                 not null,
   column_name          VARCHAR(36)          not null,
   column_value         VARCHAR(200)         not null,
   column_comment       VARCHAR(36)          not null,
   constraint PK_AUTHORIZATION_SUBJECT_EXTEN primary key (subject_id, column_id)
);

comment on table authorization_subject_extended_column is
'被授权主体扩展列';

comment on column authorization_subject_extended_column.subject_id is
'PrimaryKey';

comment on column authorization_subject_extended_column.column_id is
'pk';

comment on column authorization_subject_extended_column.column_name is
'列名';

comment on column authorization_subject_extended_column.column_value is
'列值';

comment on column authorization_subject_extended_column.column_comment is
'列注释';

/*==============================================================*/
/* Index: authorization_subject_extended_column_PK              */
/*==============================================================*/
create unique index authorization_subject_extended_column_PK on authorization_subject_extended_column (
subject_id,
column_id
);

/*==============================================================*/
/* Index: extended_column_FK                                    */
/*==============================================================*/
create  index extended_column_FK on authorization_subject_extended_column (
subject_id
);

alter table authorization_group
   add constraint FK_AUTHORIZ_GROUP_SEL_AUTHORIZ foreign key (parent_id)
      references authorization_group (group_id)
      on delete restrict on update restrict;

alter table authorization_group_subject
   add constraint FK_AUTHORIZ_GROUP_SUB_AUTHORIZ foreign key (group_id)
      references authorization_group (group_id)
      on delete restrict on update restrict;

alter table authorization_group_subject
   add constraint FK_AUTHORIZ_SUBJECT_G_AUTHORIZ foreign key (subject_id)
      references authorization_subject (subject_id)
      on delete restrict on update restrict;

alter table authorization_operation
   add constraint FK_AUTHORIZ_RESOURCE__AUTHORIZ foreign key (resource_id)
      references authorization_resource (resource_id)
      on delete restrict on update restrict;

alter table authorization_permission
   add constraint FK_AUTHORIZ_OPERATION_AUTHORIZ foreign key (resource_id, operation_id)
      references authorization_operation (resource_id, operation_id)
      on delete restrict on update restrict;

alter table authorization_resource
   add constraint FK_AUTHORIZ_RESOURCE__AUTHORIZ foreign key (parent_id)
      references authorization_resource (resource_id)
      on delete restrict on update restrict;

alter table authorization_role_resource_operation
   add constraint FK_AUTHORIZ_OPERATION_AUTHORIZ foreign key (resource_id, operation_id)
      references authorization_operation (resource_id, operation_id)
      on delete restrict on update restrict;

alter table authorization_role_resource_operation
   add constraint FK_AUTHORIZ_ROLE_OPER_AUTHORIZ foreign key (role_id)
      references authorization_role (role_id)
      on delete restrict on update restrict;

alter table authorization_role_subject
   add constraint FK_AUTHORIZ_ROLE_SUBJ_AUTHORIZ foreign key (role_id)
      references authorization_role (role_id)
      on delete restrict on update restrict;

alter table authorization_role_subject
   add constraint FK_AUTHORIZ_SUBJECT_R_AUTHORIZ foreign key (subject_id)
      references authorization_subject (subject_id)
      on delete restrict on update restrict;

alter table authorization_rolegroup_role
   add constraint FK_AUTHORIZ_ROLE_ROLE_AUTHORIZ foreign key (role_id)
      references authorization_role (role_id)
      on delete restrict on update restrict;

alter table authorization_rolegroup_role
   add constraint FK_AUTHORIZ_ROLEGROUP_AUTHORIZ foreign key (rolegroup_id)
      references authorization_rolegroup (rolegroup_id)
      on delete restrict on update restrict;

alter table authorization_rolegroup_subject
   add constraint FK_AUTHORIZ_ROLEGROUP_AUTHORIZ foreign key (rolegroup_id)
      references authorization_rolegroup (rolegroup_id)
      on delete restrict on update restrict;

alter table authorization_rolegroup_subject
   add constraint FK_AUTHORIZ_SUBJECT_R_AUTHORIZ foreign key (subject_id)
      references authorization_subject (subject_id)
      on delete restrict on update restrict;

alter table authorization_subject_extended_column
   add constraint FK_AUTHORIZ_EXTENDED__AUTHORIZ foreign key (subject_id)
      references authorization_subject (subject_id)
      on delete restrict on update restrict;

