//
//  TvArsiviStrategy.m
//  BeardedSpice
//

#import "TvArsiviStrategy.h"

@implementation TvArsiviStrategy

-(id) init
{
    self = [super init];
    if (self) {
        predicate = [NSPredicate predicateWithFormat:@"SELF LIKE[c] '*tvarsivi.com*'"];
    }
    return self;
}

-(BOOL) accepts:(TabAdapter *)tab
{
    return [predicate evaluateWithObject:[tab URL]];
}

- (BOOL)isPlaying:(TabAdapter *)tab {

    NSNumber *val = [tab
        executeJavascript:@"(function(){var v = flowplayer(document.querySelector('#fpdisplay')); return v.playing;})()"];
    
    return [val boolValue];
}

-(NSString *) toggle
{
    return @"(function(){var v = flowplayer(document.querySelector('#fpdisplay')); if (!v.playing) { v.play(); } else { v.pause(); }})()";
}

-(NSString *) previous
{
    return @"(function(){k=$('#kanal_ileri').length > 0 ? 'kanal' : 'icerik'; data = $('#'+k+'_geri').attr('rel'); $.getJSON('index.php?s=ajax&b=kanal_ileri_geri', {data: data}, function (json) { flowplayer($('#fpdisplay')[0]).load(json.vurl); $('#'+k+'_ileri').attr('rel',json.s); $('#'+k+'_geri').attr('rel',json.o); $('#tarih_saat_span').text(json.part_tarih_saat); });})()";
}

-(NSString *) next
{
    return @"(function(){k=$('#kanal_ileri').length > 0 ? 'kanal' : 'icerik'; data = $('#'+k+'_ileri').attr('rel'); $.getJSON('index.php?s=ajax&b=kanal_ileri_geri', {data: data}, function (json) { flowplayer($('#fpdisplay')[0]).load(json.vurl); $('#'+k+'_ileri').attr('rel',json.s); $('#'+k+'_geri').attr('rel',json.o); $('#tarih_saat_span').text(json.part_tarih_saat); });})()";
    // return @"(function(){return document.querySelector('#icerik_ileri').click()})()";
}

-(NSString *) pause
{
    return @"(function(){var v = flowplayer(document.querySelector('#fpdisplay')); v.pause();})()";
}

-(NSString *) displayName
{
    return @"TvArsivi";
}

-(Track *) trackInfo:(TabAdapter *)tab
{
    Track *track = [[Track alloc] init];
    [track setTrack:[tab executeJavascript:@"document.querySelector('.sol .baslik').innerText"]];
    [track setArtist:@"TvArsivi"];
    return track;
}

@end
