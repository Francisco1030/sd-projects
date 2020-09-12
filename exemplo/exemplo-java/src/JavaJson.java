import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import org.json.JSONException;
import org.json.JSONObject;

public class JavaJson {
	
	public static void main(String[] args) throws JSONException {
		String jsonString = jsonGetRequest("http://localhost:8100/exemplo/");
		
		JSONObject jsonObject = new JSONObject(jsonString);
		
		JSONObject newJSON = jsonObject.getJSONObject("_0");
		System.out.println(newJSON.getString("titulo"));
		
	}
	
	public static String jsonGetRequest(String urlQueryRequest) {
		String json = null;
		try {
			URL url = new URL(urlQueryRequest);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setInstanceFollowRedirects(false);
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Content-type", "application/json");
			connection.setRequestProperty("charset", "utf-8");
			connection.connect();
			
			InputStream inputStream = connection.getInputStream();
			json = streamToString(inputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	public static String streamToString(InputStream inputStream) {
		String texto = new Scanner(inputStream, "UTF-8").useDelimiter("\\Z").next();
		return texto;
	}

}
