/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ec.gob.dinardap.prueba.clientejarrc;

/**
 *
 * @author luis.molina
 */
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws Exception {

        ServicioDINARDAP servicioDINARDAP = new ServicioDINARDAP();
        
        /*********************************
         * Cambir el identificacion
         */
        servicioDINARDAP.getDatosDINARDAP("1002003001");

    }

}
