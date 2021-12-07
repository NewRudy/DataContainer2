package cn.keking.entity;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;
import java.util.List;

/**
 * @Author mingyuan
 * @Date 2020.06.14 16:06
 */
@Document
@Data
public class DataList {
    @Id
    String oid;
    List<String> fileList;
    String uid;
    String name;
    String origination;
    String serverNode;
    String userId;
    Date date;
    String path;
    String type;
    String singleFileName;//
    String dataTemplateId;//id去掉
    Boolean configFile;
}
