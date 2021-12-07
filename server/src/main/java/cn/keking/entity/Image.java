package cn.keking.entity;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

/**
 * @Author mingyuan
 * @Date 2020.06.11 20:18
 */
@Document
@Data
public class Image {
    @Id
    String oid;
    Date upLoadTime;
    String path;
}
