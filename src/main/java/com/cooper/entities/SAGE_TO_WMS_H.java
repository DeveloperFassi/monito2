package com.cooper.entities;
 

import java.sql.Timestamp;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name = "INTEGRAL.SAGE_TO_WMS_H")
public class SAGE_TO_WMS_H {
	
	@Id
	private long IDFICHIER_0;
	
	private String TYPEFICHIER_0;
	private String OBJETSAGE_0;
	private String NOMFICHIER_0;
	private String TRANSFERE_0;
	private Timestamp CREDAT_0;
	
	public SAGE_TO_WMS_H() {
		super();
		// TODO Auto-generated constructor stub
	}
	public SAGE_TO_WMS_H(Long iDFICHIER_0, String tYPEFICHIER_0, String oBJETSAGE_0, String nOMFICHIER_0,
			String tRANSFERE_0, Timestamp cREDAT_0) {
		super();
		IDFICHIER_0 = iDFICHIER_0;
		TYPEFICHIER_0 = tYPEFICHIER_0;
		OBJETSAGE_0 = oBJETSAGE_0;
		NOMFICHIER_0 = nOMFICHIER_0;
		TRANSFERE_0 = tRANSFERE_0;
		CREDAT_0 = cREDAT_0;
	}
	public Long getIDFICHIER_0() {
		return IDFICHIER_0;
	}
	public void setIDFICHIER_0(Long iDFICHIER_0) {
		IDFICHIER_0 = iDFICHIER_0;
	}
	public String getTYPEFICHIER_0() {
		return TYPEFICHIER_0;
	}
	public void setTYPEFICHIER_0(String tYPEFICHIER_0) {
		TYPEFICHIER_0 = tYPEFICHIER_0;
	}
	public String getOBJETSAGE_0() {
		return OBJETSAGE_0;
	}
	public void setOBJETSAGE_0(String oBJETSAGE_0) {
		OBJETSAGE_0 = oBJETSAGE_0;
	}
	public String getNOMFICHIER_0() {
		return NOMFICHIER_0;
	}
	public void setNOMFICHIER_0(String nOMFICHIER_0) {
		NOMFICHIER_0 = nOMFICHIER_0;
	}
	public String getTRANSFERE_0() {
		return TRANSFERE_0;
	}
	public void setTRANSFERE_0(String tRANSFERE_0) {
		TRANSFERE_0 = tRANSFERE_0;
	}
	public Timestamp getCREDAT_0() {
		return CREDAT_0;
	}
	public void setCREDAT_0(Timestamp cREDAT_0) {
		CREDAT_0 = cREDAT_0;
	}
	@Override
	public String toString() {
		return "SAGE_TO_WMS_H [IDFICHIER_0=" + IDFICHIER_0 + ", TYPEFICHIER_0=" + TYPEFICHIER_0 + ", OBJETSAGE_0="
				+ OBJETSAGE_0 + ", NOMFICHIER_0=" + NOMFICHIER_0 + ", TRANSFERE_0=" + TRANSFERE_0 + ", CREDAT_0="
				+ CREDAT_0 + "]";
	}
	
	
	
	
	
	
	
	
 

}
