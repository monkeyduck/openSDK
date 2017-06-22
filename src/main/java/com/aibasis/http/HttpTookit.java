package com.aibasis.http;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;


/**
 * Created by llc on 16/7/22.
 */
public class HttpTookit {

    private final static Logger logger = Logger.getLogger(HttpTookit.class);

    private static final String APPLICATION_JSON = "application/json";

    private static final String CONTENT_TYPE_TEXT_JSON = "text/json";

    // HTTP GET request
    public String sendGet(String url) throws Exception {

        HttpClient client = new DefaultHttpClient();
        HttpGet request = new HttpGet(url);

        HttpResponse response = client.execute(request);

        logger.info("\nSending 'GET' request to URL : " + url);
        logger.info("Response Code : " +
                response.getStatusLine().getStatusCode());

        BufferedReader rd = new BufferedReader(
                new InputStreamReader(response.getEntity().getContent()));

        StringBuffer result = new StringBuffer();
        String line = "";
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }

        return result.toString();

    }

//    public void sendPost(BaseItem item, List<BaseItem> itemList){
//        try{
//            String url = "http://10.172.163.4/knowledgeMessage/sendKnowledgeMessage";
////            EnvironmentType env = item.getEnvType();
////            if (env.equals(EnvironmentType.Alpha)){
////                url = "http://10.172.163.4/knowledgeMessage/sendKnowledgeMessage";
////            }
////            else if (env.equals(EnvironmentType.Online) || env.equals(EnvironmentType.Release)){
////                url = "http://10.45.139.194/knowledgeMessage/sendKnowledgeMessage";
////            }
//            HttpClient httpClient = new DefaultHttpClient();
//            HttpPost post = new HttpPost(url);
//            post.addHeader(HTTP.CONTENT_TYPE, APPLICATION_JSON);
//            JSONObject json = new JSONObject();
//            String member_id = item.getMemberId();
//            String know_name = item.getKnowledgeName();
//            String know_url = item.getKnowledgeUrl();
//            DateTime dt = new DateTime();
//            String time = dt.toString("yyyy年MM月dd日 HH:mm");
//            logger.info("time :" + time);
//            json.put("memberId", member_id);
//            json.put("knowledgeName", know_name);
//            json.put("knowledgeUrl", know_url);
//            json.put("sendKnowledgeTime", time);
//            List<String> urlList = new ArrayList<>();
//            for (BaseItem anItemList : itemList) {
//                urlList.add(anItemList.getKnowledgeUrl());
//            }
//            json.put("lastWeekKnowledgeUrlList", JSONArray.fromObject(urlList));
//            String data = json.toString();
//            logger.info("json data: "+data);
//            HttpEntity reqEntity = new StringEntity(data,"UTF-8");
//            post.setEntity(reqEntity);
//            HttpResponse response = httpClient.execute(post);
//            HttpEntity entity = response.getEntity();
//            logger.info(EntityUtils.toString(entity));
//        }catch (IOException e){
//            logger.error("post请求异常: "+e.getMessage());
//        }
//    }

    /**
     * 获取响应内容，针对MimeType为text/plan、text/json格式
     *
     * @param content
     *            响应内容
     * @param response
     *            HttpResponse对象
     * @param method
     *            请求方式 GET|POST
     * @return 转为UTF-8的字符串
     * @throws ParseException
     * @throws IOException
     * @author Jie
     * @date 2015-2-28
     */
    public static String parseRepsonse(StringBuilder content, HttpResponse response, String method) throws ParseException, IOException {
        StatusLine statusLine = response.getStatusLine();
        int statusCode = statusLine.getStatusCode();// 响应码
        String reasonPhrase = statusLine.getReasonPhrase();// 响应信息
        if (statusCode == 200) {// 请求成功
            HttpEntity entity = response.getEntity();
            logger.info("MineType:" + entity.getContentType().getValue());
            content.append(EntityUtils.toString(entity));
        } else {
            logger.error(method + "：code[" + statusCode + "],desc[" + reasonPhrase + "]");
        }
        return content.toString();
    }

    public static void main(String args[]){
        String url = "http://stat.hixiaole.com:8081/log/search/realtime?date=2017-02-28&memberId=af4b8ee8d3c94ff599e2877224ee3e130.85867965";
        HttpTookit http = new HttpTookit();
        try {
            http.sendGet(url);
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
