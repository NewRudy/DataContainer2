package cn.keking.dao;


import cn.keking.entity.ReferenceZeroTime;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author mingyuan
 * @Date 2020.07.09 18:37
 */
public interface ReferenceZeroTimeDao extends MongoRepository<ReferenceZeroTime, String> {
    ReferenceZeroTime findFirstByDataListComOid(String oid);
}
