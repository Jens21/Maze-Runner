import numpy as np
from matplotlib import pyplot as plt
import random

def add_tuples(tuple_a, tuple_b):
    return tuple(np.array(tuple_a) + np.array(tuple_b))

def subtract_tuples(tuple_a, tuple_b):
    return tuple(np.array(tuple_a) - np.array(tuple_b))

class Maze_1:
    
    queue=[]
    prob_to_turn_while_going_back=0.05
    prob_to_to_go_straight_ahead=0.8

    walkable_parts=2000

    width=10
    height=10

    def __init__(self, width, height):
        self.width=width
        self.height=height

    def create_maze(self):   
        for i in range(10):
            maze=self.create(width, height)

            if np.sum(maze)>self.walkable_parts:
                return maze
        
        return None

    def create(self, width, height):
        def is_location_valid(location):
            if location[0]<0 or location[0]>=width or location[1]<0 or location[1]>=height:
                return False

            return True
        def have_location_been_visited(location):
            return maze[location[0], location[1]]==1
        def is_location_too_close_to_a_visited_one(location, current_location):
            check_directions=[(0,1), (1,0), (0,-1), (-1,0)]

            for direction in check_directions:
                loc=add_tuples(location, direction)

                if is_location_valid(loc) and loc!=current_location and have_location_been_visited(loc):
                    return True

            return False

        def calculate_possible_directions(current_location):
            possible_directions=[(0,1), (1,0), (0,-1), (-1,0)]

            i=0
            while i<len(possible_directions):
                direction=possible_directions[i]
                loc=add_tuples(current_location, direction)

                if not is_location_valid(loc) or have_location_been_visited(loc) or is_location_too_close_to_a_visited_one(loc, current_location):
                    possible_directions.remove(direction)
                    i-=1

                i+=1

            return possible_directions
        def get_next_location(current_location, preferred_direction, gone_back):
            if gone_back and np.random.uniform()>self.prob_to_turn_while_going_back:
                return None

            possible_directions = calculate_possible_directions(current_location)

            if len(possible_directions)==0:
                return None

            if preferred_direction in possible_directions:
                length=len(possible_directions)

                to_add=int(length/(1-self.prob_to_to_go_straight_ahead)*self.prob_to_to_go_straight_ahead)
                for i in range(to_add): 
                    possible_directions.append(preferred_direction)

            next_direction = random.choice(possible_directions)
            return add_tuples(current_location, next_direction)

        def calculate_preferred_direction(last_location, current_location):
            return subtract_tuples(current_location, last_location)

        maze=np.zeros((self.width, self.height))
        start_location=(int(self.height/2),0)
        maze[start_location[0], start_location[1]]=1
        queue=[start_location]

        gone_back=False
        preferred_direction=(0,1)
        current_location=start_location

        while len(queue)!=0:
            next_location=get_next_location(current_location, preferred_direction, gone_back)

            if next_location  is None:    # go a step back
                loc = queue.pop()

                if len(queue)!=0:
                    current_location=queue[-1]
                    preferred_direction=calculate_preferred_direction(current_location, loc)
                    gone_back=True
            else:                       # go to the calculated new location
                preferred_direction=calculate_preferred_direction(current_location, next_location)
                current_location=next_location
                gone_back=False
                queue.append(current_location)
                maze[current_location[0], current_location[1]]=1
        
        return maze

class Maze_2:

    width=10
    height=10

    n_pre_init_spots=200

    def __init__(self, width, height):
        self.width=width
        self.height=height
    
    def pre_init_spots(self):
        pre_spots=[]
        for i in range(self.n_pre_init_spots):
            x=np.random.randint(low=0, high=width)
            y=np.random.randint(low=0, high=height)

            pre_spots.append((x,y))
        
        return pre_spots

    def connect_spots(self, spot, to_spot, spots):
        x=spot[0]
        y=spot[1]

        direc_x=np.sign(to_spot[0]-x)
        direc_y=np.sign(to_spot[1]-y)

        while x!=to_spot[0] or y!=to_spot[1]:
            av_x=np.abs(x-to_spot[0])
            av_y=np.abs(y-to_spot[1])
            if av_x/(av_x+av_y)<np.random.uniform()/3:#np.abs(x-to_spot[0])!=0:
                y+=direc_y
            else:
                x+=direc_x

            spots.append((x,y))

        return spots

    def connect_pre_spots(self, pre_spots, spots):
        for spot in pre_spots:
            distances=np.linalg.norm(np.subtract(spot, spots), axis=1)
            sorted_indexes=np.argsort(distances)

            if distances[sorted_indexes[0]]!=0:
                to_spot=spots[sorted_indexes[0]]

                spots=self.connect_spots(spot, to_spot, spots)


        return spots

    def convert_spots_to_maze(self, spots):
        maze=np.zeros((self.width, self.height))

        for (x,y) in spots:
            maze[x,y]=1

        return maze

    def create_maze(self):
        start_location=(int(self.height/2),0)
        end_location=(int(self.height/2),width-1)

        spots=[start_location]

        pre_spots=self.pre_init_spots()
        pre_spots.append(end_location)

        spots=self.connect_pre_spots(pre_spots, spots)
        #spots=pre_spots

        maze=self.convert_spots_to_maze(spots)

        return maze

class Maze_3:

    width=10
    height=10

    n_pre_init_spots=500

    circle_radius=25

    def __init__(self, width, height):
        self.width=width
        self.height=height

        #np.random.seed(12345)
    
    def pre_init_spots(self):
        pre_spots=[]
        for i in range(self.n_pre_init_spots):
            x=0.5
            y=0.5
            while np.linalg.norm(x-0.5)<0.1 and np.linalg.norm(y-0.5)<0.3:
                x=np.random.beta(0.2,0.2)
                y=np.random.uniform()

            x=int(x*width)
            y=int(y*height)

            if x>=width:
                x-=1
            if y>=height:
                y-=1

            pre_spots.append((x,y))
        
        return pre_spots

    def connect_spots(self, spot, to_spot, spots):
        x=spot[0]
        y=spot[1]

        direc_x=np.sign(to_spot[0]-x)
        direc_y=np.sign(to_spot[1]-y)

        while x!=to_spot[0] or y!=to_spot[1]:
            av_x=np.abs(x-to_spot[0])
            av_y=np.abs(y-to_spot[1])
            if av_x/(av_x+av_y)<np.random.uniform()/2:#np.abs(x-to_spot[0])!=0:
                y+=direc_y
            else:
                x+=direc_x

            spots.append((x,y))

        return spots

    def connect_pre_spots(self, pre_spots, start_spot):
        spots=[start_spot]

        distances=np.linalg.norm(np.subtract(start_spot, pre_spots), axis=1)
        sorted_indexes=np.argsort(distances)
        pre=pre_spots
        pre_spots=[]
        for i in range(len(pre)):
            pre_spots.append(pre[sorted_indexes[i]])

        for spot in pre_spots:
            distances=np.linalg.norm(np.subtract(spot, spots), axis=1)
            sorted_indexes=np.argsort(distances)

            if distances[sorted_indexes[0]]!=0:
                to_spot=spots[sorted_indexes[0]]

                spots=self.connect_spots(spot, to_spot, spots)

        return spots

    def convert_spots_to_maze(self, spots):
        maze=np.zeros((self.width, self.height))


        for (x,y) in spots:
            maze[x,y]=1

        return maze

    def remove_spots_in_cirlce(self, spots):
        i=0
        while i<len(spots):
            spot=spots[i]
            middle_point=(width/2,height/2)
            dist=np.linalg.norm(subtract_tuples(spot, middle_point))
            
            if dist>self.circle_radius:
                del spots[i]
                i-=1

            i+=1

        return spots

    def create_maze(self):
        start_location=(int(self.height/2),0)
        end_location=(int(self.height/2),width-1)

        pre_spots=self.pre_init_spots()
        pre_spots=self.remove_spots_in_cirlce(pre_spots)
        pre_spots.append(end_location)

        spots=self.connect_pre_spots(pre_spots, start_location)
        #spots=pre_spots

        maze=self.convert_spots_to_maze(spots)

        return maze


def show_maze(maze):
    if maze is not None:
        plt.imshow(maze, interpolation='nearest')
        plt.show()

if __name__=="__main__":

    width=50
    height=50

    #maze=Maze_1(width, height).create_maze()
    #maze=Maze_2(width, height).create_maze()
    maze=Maze_3(width, height).create_maze()

    show_maze(maze)
