//
//  Users.h
//  EveryDoAgain
//
//  Created by Johnny on 2015-02-04.
//  Copyright (c) 2015 RS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *todos;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addTodosObject:(Todo *)value;
- (void)removeTodosObject:(Todo *)value;
- (void)addTodos:(NSSet *)values;
- (void)removeTodos:(NSSet *)values;

@end
