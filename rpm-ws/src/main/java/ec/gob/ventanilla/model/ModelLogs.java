package ec.gob.ventanilla.model;

import java.io.Serializable;

public class ModelLogs implements Serializable {
	private static final long serialVersionUID = 1L;

	private String log;
	private String token;

	public ModelLogs() {

	}

	public String getLog() {
		return log;
	}

	public void setLog(String log) {
		this.log = log;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

}
