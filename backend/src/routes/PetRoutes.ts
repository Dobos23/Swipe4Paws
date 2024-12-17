import PetController from "../controllers/PetController";
import { Router } from "express";
import { isShelter } from "../middleware/auth";

const petRoutes = Router();
const petController = new PetController();
//const router = express.Router();

// Defines the routes
petRoutes.get('/', petController.getAllPets);
petRoutes.post('/', petController.addPet);
petRoutes.put('/:id', isShelter, petController.updatePet);
petRoutes.delete('/:id', isShelter, petController.deletePet);
petRoutes.get('/search', petController.searchPets);

export default petRoutes;