import zlib, base64

encodedStr = "IyEvYmluL2Jhc2gKY2xlYXIKZWNobyAtZSAiXGVbNDszMW0gU0tQIFByb2R1Y3Rpb25zICEhISBcZVswbSIKZWNobyAtZSAiXGVbMTszNG0gUHJlc2VudHMgXGVbMG0iCmVjaG8gLWUgIlxlWzE7MzJtIFRCT01CLUVESVRFRCBcZVswbSIKZWNobyAiUHJlc3MgRW50ZXIgVG8gQ29udGludWUiCnJlYWQgYTEKaWYgW1sgLXMgdXBkYXRlLlNLUCBdXTt0aGVuCmVjaG8gIkFsbCBSZXF1aXJlbWVudHMgRm91bmQuLi4uIgplbHNlCmVjaG8gJ0luc3RhbGxpbmcgUmVxdWlyZW1lbnRzLi4uLicKZWNobyAuCmVjaG8gLgphcHQgaW5zdGFsbCBmaWdsZXQgdG9pbGV0IHB5dGhvbiBjdXJsIC15CmFwdCBpbnN0YWxsIHB5dGhvbjMtcGlwCnBpcCBpbnN0YWxsIC1yIHJlcXVpcmVtZW50cy50eHQKZWNobyBUaGlzIFNjcmlwdCBXYXMgTWFkZSBCeSBTS1AgPnVwZGF0ZS5zcGVlZHgKZWNobyBSZXF1aXJlbWVudHMgSW5zdGFsbGVkLi4uLgplY2hvIFByZXNzIEVudGVyIFRvIENvbnRpbnVlLi4uCnJlYWQgdXBkCmZpCndoaWxlIDoKZG8Kcm0gKi54eHggPi9kZXYvbnVsbCAyPiYxCmNsZWFyCmVjaG8gLWUgIlxlWzE7MzFtIgpmaWdsZXQgVEJPTUItRURJVEVECmVjaG8gLWUgIlxlWzE7MzRtIENyZWF0ZWQgQnkgXGVbMTszMm0iCnRvaWxldCAtZiBtb25vMTIgLUYgYm9yZGVyIFNLUAplY2hvIC1lICJcZVs0OzM0bSBUaGlzIEJvbWJlciBXYXMgQ3JlYXRlZCBCeSBTS1AgXGVbMG0iCmVjaG8gIiAiCmVjaG8gLWUgIlxlWzQ7MzFtIFBsZWFzZSBSZWFkIEluc3RydWN0aW9uIENhcmVmdWxseSAhISEgXGVbMG0iCmVjaG8gIiAiCmVjaG8gIlByZXNzIDEgVG8gIFN0YXJ0IFNNUyBCb21iZXIgIgplY2hvICJQcmVzcyAyIFRvICBTdGFydCBDYWxsIEJvbWJlciAiCmVjaG8gIlByZXNzIDMgVG8gIFVwZGF0ZSAoV29ya3MgT24gTGludXggQW5kIExpbnV4IEVtdWxhdG9ycykgIgplY2hvICJQcmVzcyA0IFRvICBWaWV3IEZlYXR1cmVzICIKZWNobyAiUHJlc3MgNSBUbyAgRXhpdCAiCnJlYWQgY2gKaWYgWyAkY2ggLWVxIDEgXTt0aGVuCmNsZWFyCmVjaG8gLWUgIlxlWzE7MzJtIgpybSAqLnh4eCA+L2Rldi9udWxsIDI+JjEKcHl0aG9uMyBib21iZXIucHkKcm0gKi54eHggPi9kZXYvbnVsbCAyPiYxCmV4aXQgMAplbGlmIFsgJGNoIC1lcSAyIF07dGhlbgpjbGVhcgplY2hvIC1lICJcZVsxOzMybSIKZWNobyAnQ2FsbCBCb21iIEJ5IFNLUCc+IGNhbGwueHh4CnB5dGhvbjMgYm9tYmVyLnB5IGNhbGwKcm0gKi54eHggPi9kZXYvbnVsbCAyPiYxCmV4aXQgMAplbGlmIFsgJGNoIC1lcSAzIF07dGhlbgpjbGVhcgphcHQgaW5zdGFsbCBnaXQgLXkKZWNobyAtZSAiXGVbMTszNG0gRG93bmxvYWRpbmcgTGF0ZXN0IEZpbGVzLi4uIgpnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL3NrcDEyMS9UQk9NQi1FRElURUQKaWYgW1sgLXMgVEJvbWIvVEJvbWIuc2ggXV07dGhlbgpjZCBUQk9NQi1FRElURUQKY3AgLXIgLWYgKiAuLiA+IHRlbXAKY2QgLi4Kcm0gLXJmICBUQm9tYiA+PiB0ZW1wCnJtIHVwZGF0ZS5zcGVlZHggPj4gdGVtcApybSB0ZW1wCmNobW9kICt4IFRCb21iLnNoCmZpCmVjaG8gLWUgIlxlWzE7MzJtIFRCb21iIFdpbGwgUmVzdGFydCBOb3cuLi4iCmVjaG8gLWUgIlxlWzE7MzJtIEFsbCBUaGUgUmVxdWlyZWQgUGFja2FnZXMgV2lsbCBCZSBJbnN0YWxsZWQuLi4iCmVjaG8gLWUgIlxlWzE7MzRtIFByZXNzIEVudGVyIFRvIFByb2NlZWQgVG8gUmVzdGFydC4uLiIKcmVhZCBhNgouL1RCb21iLnNoCmV4aXQKZWxpZiBbICRjaCAtZXEgNCBdO3RoZW4KY2xlYXIKZWNobyAtZSAiXGVbMTszM20iCmZpZ2xldCBUQk9NQi1FRElURUQKZWNobyAtZSAiXGVbMTszNG1DcmVhdGVkIEJ5IFxlWzE7MzRtIgp0b2lsZXQgLWYgbW9ubzEyIC1GIGJvcmRlciBTS1AKZWNobyAgIiAiCmVjaG8gLWUgIlxlWzE7MzJtICAgICAgICAgICAgICAgICAgIEZlYXR1cmVzXGVbMTszNG0iCmVjaG8gIiAgWytdIFVubGltaXRlZCBBbmQgU3VwZXItRmFzdCBCb21iaW5nIgplY2hvICIgIFsrXSBJbnRlcm5hdGlvbmFsIEJvbWJpbmciCmVjaG8gIiAgWytdIENhbGwgQm9tYmluZyAiCmVjaG8gIiAgWytdIFByb3RlY3Rpb24gTGlzdCIKZWNobyAiICBbK10gQXV0b21hdGVkIEZ1dHVyZSBVcGRhdGVzIgplY2hvICIgIFsrXSBFYXN5IFRvIFVzZSBBbmQgRW1iZWQgaW4gQ29kZSIKZWNobyAiIgplY2hvICIiCmVjaG8gLWUgIlxlWzE7MzFtIFRoaXMgU2NyaXB0IGlzIE9ubHkgRm9yIEVkdWNhdGlvbmFsIFB1cnBvc2VzIG9yIFRvIFByYW5rLlxlWzBtIgplY2hvIC1lICJcZVsxOzMxbSBEbyBub3QgVXNlIFRoaXMgVG8gSGFybSBPdGhlcnMuIFxlWzBtIgplY2hvIC1lICJcZVsxOzMxbSBJIEFtIE5vdCBSZXNwb25zaWJsZSBGb3IgVGhlIE1pc3VzZSBPZiBUaGUgU2NyaXB0LiBcZVswbSIKZWNobyAtZSAiXGVbMTszMm0gTWFrZSBTdXJlIFRvIFVwZGF0ZSBpdCBJZiBJdCBEb2VzIG5vdCBXb3JrLlxlWzBtIgplY2hvICAiICIKZWNobyAiUHJlc3MgRW50ZXIgVG8gR28gSG9tZSIKcmVhZCBhMwpjbGVhcgplbGlmIFsgJGNoIC1lcSA1IF07dGhlbgpjbGVhcgplY2hvIC1lICJcZVsxOzMxbSIKZmlnbGV0IFRCT01CLUVESVRFRAplY2hvIC1lICJcZVsxOzM0bSBDcmVhdGVkIEJ5IFxlWzE7MzJtIgp0b2lsZXQgLWYgbW9ubzEyIC1GIGJvcmRlciBTS1AKZWNobyAiICIKZXhpdCAwCmVsc2UKZWNobyAtZSAiXGVbNDszMm0gSW52YWxpZCBJbnB1dCAhISEgXGVbMG0iCmVjaG8gIlByZXNzIEVudGVyIFRvIEdvIEhvbWUiCnJlYWQgYTMKY2xlYXIKZmkKZG9uZQ=="

exec(base64.b64decode(encodedStr))
