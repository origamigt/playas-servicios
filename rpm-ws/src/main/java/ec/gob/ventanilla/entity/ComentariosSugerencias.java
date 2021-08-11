package ec.gob.ventanilla.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "comentarios_sugerencias")
public class ComentariosSugerencias {

	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	@Column(name = "fecha")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonIgnore
	private Date fecha;
	@Column(name = "text_comentario")
	private String textComentario;
	@Column(name = "user_")
	private Integer user;

	public ComentariosSugerencias() {
	}
        
        

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public String getTextComentario() {
		return textComentario;
	}

	public void setTextComentario(String textComentario) {
		this.textComentario = textComentario;
	}

	public Integer getUser() {
		return user;
	}

	public void setUser(Integer user) {
		this.user = user;
	}

	
	
}
