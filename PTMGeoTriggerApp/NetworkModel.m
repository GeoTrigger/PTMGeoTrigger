
#import "NetworkModel.h"

#define SITEURL     [NSString stringWithFormat:@"http://jadeintermedia.com/ubipushservice"]
//#define SITEURL     @"http://192.168.1.57/ubi-demo"

static NetworkModel *sharedNetworkModel;
@implementation NetworkModel
- (id)init{
    self = [super init];
    if(self)
    {
    }
    return self;
}
+(NetworkModel *)sharedNetworkModel
{
    if (!sharedNetworkModel)
    {
        sharedNetworkModel = [[NetworkModel alloc] init];
    }
    return sharedNetworkModel;
}
-(AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


#pragma mark - User Session common calls

-(void)sendTerminateMessage
{
    //app_id,device_id,device_token,message,lat,lng
    
    AppDelegate *del = [self appDelegate];
    NSDictionary *queryParams;
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:@"com.sstig.Speeddemo",@"app_id",[userdefaults objectForKey:@"deviceid"],@"device_id",@"App terminated",@"message",@"31.123",@"lat",@"121.23",@"lng",[userdefaults objectForKey:@"devicetoken"],@"device_token",nil];
    NSError *err;
    NSDictionary *result = [self syncCallServerWithDict:queryParams error:&err andurl:[NSString stringWithFormat:@"%@/index.php",SITEURL]];
    
    NSLog(@"%@",[NSString stringWithFormat:@"%@/index.php",SITEURL]);
    if (err)
    {
        NSLog(@"%@",[err description]);
    }
    else
    {
        NSLog(@"%@",result);
    }
}

-(void)sendcornStartMessage
{
    //app_id,device_id,device_token,message,lat,lng
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    AppDelegate *del = [self appDelegate];
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:@"ubi",@"app_id",[userdefaults objectForKey:@"deviceid"],@"device_id",[userdefaults objectForKey:@"devicetoken"],@"device_token",@"You have walked pass the boundary do you want to ‘Cancel’ or ‘Re-launch’ your app.",@"message",@"31.123",@"lat",@"121.23",@"lng",nil];
    NSError *err;
    NSDictionary *result = [self syncCallServerWithDict:queryParams error:&err andurl:[NSString stringWithFormat:@"%@/cronstart.php",SITEURL]];
    if (err)
    {
        NSLog(@"%@",[err description]);
    }
    else
    {
        NSLog(@"%@",result);
    }
}

-(void)sendCornStopMessage
{
        //app_id,device_id,device_token,message,lat,lng
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
        if ([userdefaults objectForKey:@"deviceid"]!=nil) {
        
    
        AppDelegate *del = [self appDelegate];
        NSDictionary *queryParams;
        queryParams = [NSDictionary dictionaryWithObjectsAndKeys:@"ubi",@"app_id",[userdefaults objectForKey:@"deviceid"],@"device_id",[userdefaults objectForKey:@"devicetoken"],@"device_token",@"stop cron",@"message",@"31.123",@"lat",@"121.23",@"lng",nil];
        NSError *err;
        NSDictionary *result = [self syncCallServerWithDict:queryParams error:&err andurl:[NSString stringWithFormat:@"%@/cronstop.php",SITEURL]];
        if (err)
        {
            NSLog(@"%@",[err description]);
        }
        else
        {
            NSLog(@"%@",result);
        }
    }

}




#pragma mark - General Methods

- (NSDictionary *)syncCallServerWithDict:(NSDictionary *)inDict error:(NSError **)inErr andurl:(NSString *)url
{
    // Clear error object
    *inErr = nil;
    
    // Server URL
    NSString *urlString = url;
    
    // Build request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
   // [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    
    // Add data
   //NSData *json = [NSJSONSerialization dataWithJSONObject:inDict options:0 error:inErr];
    //if(*inErr != nil || json == nil)
       // return nil;
    
    // add the text form fields
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    for (id key in inDict)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:[inDict objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }

    
    
    [request setHTTPBody:body];
    
    // Call the server
    NSURLResponse *resp = nil;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:inErr];
    if(*inErr != nil || returnData == nil)
        return nil;
    NSString *myString;
    myString = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
    NSLog(@"res -- %@",myString);
    // Process response
    NSDictionary *ret = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingAllowFragments error:inErr];
    if(*inErr != nil || ret == nil)
        return nil;
    else
        return ret;
}
@end
