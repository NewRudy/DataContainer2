package cn.keking.utils;

import cn.keking.bean.JsonResult;
import cn.keking.enums.ResultEnum;

/**
 * @Author mingyuan
 * @Date 2020.06.15 17:03
 */
public class ResultUtils {
    public static JsonResult success() {
        return success(null);
    }

    public static JsonResult success(Object obj) {
        JsonResult jsonResult = new JsonResult();
        jsonResult.setMessage(ResultEnum.SUCCESS.getMsg());
        jsonResult.setCode(ResultEnum.SUCCESS.getCode());
        jsonResult.setData(obj);
        return jsonResult;
    }


    public static JsonResult error(Integer code, String msg) {
        JsonResult jsonResult = new JsonResult();
        jsonResult.setCode(code);
        jsonResult.setMessage(msg);
        jsonResult.setData(null);
        return jsonResult;
    }
}
