<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<#include "/java_copyright.include">
package ${basepackage}.mapper; 

<#include "java_imports.include">
import org.springframework.stereotype.Repository;
import org.springframework.dao.DataAccessException;
import ${basepackage}.pojo.${className};

/**
 * ${className}Mapper
 */
@Repository
public interface ${className}Mapper {

	<#list table.columns as column>
		<#if column.unique>
	/**
	 * 根据${column.columnNameLower}查询${className}
	 */
	public ${className} queryBy${column.columnName}(${column.javaType} ${column.columnNameLower}) throws DataAccessException;
	
	/**
	 * 根据${column.columnNameLower}删除${className}
	 */
	public void deleteBy${column.columnName}(${column.javaType} ${column.columnNameLower}) throws DataAccessException;
	
		</#if>
	</#list>
	/**
	 * 根据参数统计符合条件的${className}结果总数
	 */
	public long countForQueryList(${className} ${classNameLower}) throws DataAccessException;
	
	/**
	 * 分页、条件、排序查询${className}
	 */
	public List<${className}> queryList(${className} ${classNameLower}) throws DataAccessException;
	
	/**
	 * 添加${className}
	 */
	public void save(${className} ${classNameLower}) throws DataAccessException;
	
	/**
	 * 更新${className}
	 */
	public void update(${className} ${classNameLower}) throws DataAccessException;
	
}