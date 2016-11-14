//
//  FKFlickrMachinetagsGetNamespaces.m
//  FlickrKit
//
//  Generated by FKAPIBuilder.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrMachinetagsGetNamespaces.h" 

@implementation FKFlickrMachinetagsGetNamespaces



- (BOOL) needsLogin {
    return NO;
}

- (BOOL) needsSigning {
    return NO;
}

- (FKPermission) requiredPerms {
    return -1;
}

- (NSString *) name {
    return @"flickr.machinetags.getNamespaces";
}

- (BOOL) isValid:(NSError **)error {
    BOOL valid = YES;
	NSMutableString *errorDescription = [[NSMutableString alloc] initWithString:@"You are missing required params: "];

	if(error != NULL) {
		if(!valid) {	
			NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorDescription};
			*error = [NSError errorWithDomain:FKFlickrKitErrorDomain code:FKErrorInvalidArgs userInfo:userInfo];
		}
	}
    return valid;
}

- (NSDictionary *) args {
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
	if(self.predicate) {
		[args setValue:self.predicate forKey:@"predicate"];
	}
	if(self.per_page) {
		[args setValue:self.per_page forKey:@"per_page"];
	}
	if(self.page) {
		[args setValue:self.page forKey:@"page"];
	}

    return [args copy];
}

- (NSString *) descriptionForError:(NSInteger)error {
    switch(error) {
		case FKFlickrMachinetagsGetNamespacesError_NotAValidPredicate:
			return @"Not a valid predicate.";
		case FKFlickrMachinetagsGetNamespacesError_InvalidAPIKey:
			return @"Invalid API Key";
		case FKFlickrMachinetagsGetNamespacesError_ServiceCurrentlyUnavailable:
			return @"Service currently unavailable";
		case FKFlickrMachinetagsGetNamespacesError_WriteOperationFailed:
			return @"Write operation failed";
		case FKFlickrMachinetagsGetNamespacesError_FormatXXXNotFound:
			return @"Format \"xxx\" not found";
		case FKFlickrMachinetagsGetNamespacesError_MethodXXXNotFound:
			return @"Method \"xxx\" not found";
		case FKFlickrMachinetagsGetNamespacesError_InvalidSOAPEnvelope:
			return @"Invalid SOAP envelope";
		case FKFlickrMachinetagsGetNamespacesError_InvalidXMLRPCMethodCall:
			return @"Invalid XML-RPC Method Call";
		case FKFlickrMachinetagsGetNamespacesError_BadURLFound:
			return @"Bad URL found";
  
		default:
			return @"Unknown error code";
    }
}

@end
