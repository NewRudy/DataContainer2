package cn.keking.dao;


import cn.keking.entity.BulkDataLink2;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author mingyuan
 * @Date 2020.12.21 16:38
 */
public interface BulkDataLinkDao2 extends MongoRepository<BulkDataLink2, String> {
    BulkDataLink2 findFirstByZipOid(String oid);

    BulkDataLink2 findFirstByName(String name);

}
