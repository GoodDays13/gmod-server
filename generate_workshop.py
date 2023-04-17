from workshop_generator import WorkshopGenerator

# wg = WorkshopGenerator()
# wg.configure(output_directory='garrysmod\lua\autorun\server')
# collections = [
#     wg.get_workshop_collection(2897213518),
#     wg.get_workshop_collection(2961097669)
# ]
# wg.write_workshop_file(collections=collections, filename='test.lua')

wg = WorkshopGenerator(output_directory='garrysmod/lua/autorun/server')

server_collection = wg.get_workshop_collection(2961097669)

wg.write_workshop_file(workshop_collection=server_collection, filename='server_workshop.lua')
