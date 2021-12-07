package cn.keking.dao;

import cn.keking.entity.TimeStamp;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Date;

/**
 * @Author mingyuan
 * @Date 2021.06.01 19:50
 */
public interface TimeStampDao extends MongoRepository<TimeStamp, String> {
    TimeStamp findFirstByTime(Date time);
}
