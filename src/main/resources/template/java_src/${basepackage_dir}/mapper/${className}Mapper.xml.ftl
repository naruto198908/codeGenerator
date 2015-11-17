<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basepackage}.mapper.${className}Mapper">

	<#list table.columns as column>
		<#if column.unique>
	<!-- 根据${column.columnNameLower}查询${className} -->
	<select id="queryBy${column.columnName}" resultType="${column.javaType}" parameterType="${className}">
		SELECT FROM ${table.sqlName}
		WHERE ${column.sqlName} = ${"#{"}${column.columnNameLower}${"}"}
	</select>
	
	<!-- 根据${column.columnNameLower}删除${className} -->
	<delete id="deleteBy${column.columnName}" parameterType="${className}">
		DELETE FROM ${table.sqlName}
		WHERE ${column.sqlName} = ${"#{"}${column.columnNameLower}${"}"}
	</delete>
	
		</#if>
	</#list>
	
	<!-- 根据参数统计符合条件的结果总数 -->
	<select id="countForQueryList" resultType="long" parameterType="${className}" >
		SELECT COUNT(1) FROM ${table.sqlName}
		<include refid="where_query_list" />
	</select>
	
	<!-- 分页、条件、排序查询 -->
	<select id="queryList" resultType="${className}" parameterType="${className}" >
		SELECT * FROM ${table.sqlName}
		<include refid="where_query_list" />
        <choose>
            <when test="orderField!=null and orderField!='' and orderDirection!=null and orderDirection!=''">
                ORDER BY ${r"${orderField} ${orderDirection}"}
            </when>
            <otherwise>
                ORDER BY ${table.pkColumn.sqlName} DESC
            </otherwise>
        </choose>
		LIMIT ${r"#{startIndex}, #{numPerPage}"}
	</select>
	
	<sql id="where_query_list">
		<where>
			<if test="true">AND 1=1 </if>
		</where>
	</sql>
	
	<!-- 添加 -->
	<insert id="save" parameterType="${className}" >
		INSERT INTO ${table.sqlName}
		(<#list table.columns as column >${column.sqlName}<#if column_has_next>,</#if></#list>)
		VALUES
		(<#list table.columns as column >${"#{"}${column.columnNameLower}${"}"}<#if column_has_next>,</#if></#list>)
	</insert>
	
	<!-- 更新 -->
	<update id="update" parameterType="${className}" >
		UPDATE ${table.sqlName}
		SET 
		<#list table.columns as column >
			<#if !column.pk>
		${column.sqlName}=${"#{"}${column.columnNameLower}${"}"}<#if column_has_next>,</#if>
			</#if>
		</#list>
		
		WHERE ${table.pkColumn.sqlName} = ${"#{"}${table.pkColumn.columnNameLower}${"}"}
	</update>
	
</mapper>