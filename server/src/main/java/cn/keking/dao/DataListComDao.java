package cn.keking.dao;


import cn.keking.entity.DataListCom;
import cn.keking.entity.DataListCom2;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author mingyuan
 * @Date 2020.07.08 14:08
 */
public interface DataListComDao extends MongoRepository<DataListCom, String> {
    DataListCom findFirstByOid(String oid);

    void insert(DataListCom2 dataListCom2);
}
