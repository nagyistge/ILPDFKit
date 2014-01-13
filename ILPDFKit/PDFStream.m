

#import "PDFStream.h"
#import "PDFDictionary.h"

@implementation PDFStream
{
    CGPDFStreamRef _strm;
    NSData* _data;
    PDFDictionary* _dictionary;
    CGPDFDataFormat _dataFormat;
}



-(id)initWithStream:(CGPDFStreamRef)pstrm
{
    self = [super init];
    if(self != nil)
    {
        _strm = pstrm;
    }
    
    return self;
}

#pragma mark - Getter

-(PDFDictionary*)dictionary
{
    if(_dictionary == nil)
    {
        CGPDFDictionaryRef dict = CGPDFStreamGetDictionary(_strm);
        if(dict)
        {
            _dictionary = [[PDFDictionary alloc] initWithDictionary:dict];
        }
    }
    return _dictionary;
}

- (void)_readData {
    CFDataRef dat = CGPDFStreamCopyData(_strm, &_dataFormat);
    _data = ((__bridge NSData*)dat);
    CFRelease(dat);

}

-(CGPDFDataFormat)dataFormat
{
    if(_data == nil)
    {
        [self _readData];
    }
    
    return _dataFormat;
}

-(NSData*)data
{
    if(_data == nil)
    {
        [self _readData];
    }
    
    return _data;
}

@end
