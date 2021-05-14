package com.cj.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author chengzhi
 * @version 1.0
 * @Description
 * @date 2021/4/28 11:27
 */
@Repository("logInfoDao")
public interface LogInfoMapper {
    /**
     * 新增日志数据
     */
    public Integer addLogInfo(@Param("logType")String logType,
                              @Param("appendAddress") String appendAddress,
                              @Param("description")String description);
}
