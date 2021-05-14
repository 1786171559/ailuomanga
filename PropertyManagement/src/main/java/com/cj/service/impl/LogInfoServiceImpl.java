package com.cj.service.impl;

import com.cj.mapper.LogInfoMapper;

import com.cj.service.ILogInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("logInfoService")
@Transactional
public class LogInfoServiceImpl implements ILogInfoService {
    @Autowired
    private LogInfoMapper logInfoDao;
    @Transactional(propagation = Propagation.NESTED)
    public Integer addLogInfo(String logType, String appendAddress, String description) {
       return logInfoDao.addLogInfo(logType,appendAddress,description);
    }
}
