/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package exam.elmassignmentrest;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;

/**
 * REST Web Service
 *
 * @author danie
 */
@Path("counter")
public class CounterService {
static int number;
static Gson gson = new Gson();

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of CounterService
     */
    public CounterService() {
    }

    /**
     * Retrieves representation of an instance of exam.elmassignmentrest.CounterService
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getJson() {
        JsonObject jo = new JsonObject();
       
        jo.addProperty("value", String.valueOf(number));
        return gson.toJson(jo);
    }

    /**
     * PUT method for updating or creating an instance of CounterService
     * @param value
     */
    @PUT
    @Path("{value}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(@PathParam("value") int value) {
        number = value;
    }
}
