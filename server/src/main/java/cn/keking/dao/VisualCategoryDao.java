package cn.keking.dao;

import cn.keking.entity.VisualCategory;
import org.springframework.data.mongodb.repository.MongoRepository;

/**
 * @Author mingyuan
 * @Date 2020.07.17 16:06
 */
public interface VisualCategoryDao extends MongoRepository<VisualCategory, String> {
    VisualCategory findFirstByOid(String oid);
}
