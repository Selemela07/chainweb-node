{-# LANGUAGE OverloadedStrings #-}

-- This module is auto-generated. DO NOT EDIT IT MANUALLY.

module Chainweb.Pact.Transactions.CoinV6Transactions ( transactions ) where

import Data.Bifunctor (first)
import System.IO.Unsafe

import Chainweb.Transaction
import Chainweb.Utils

transactions :: [ChainwebTransaction]
transactions =
  let decodeTx t =
        fromEitherM . (first (userError . show)) . codecDecode (chainwebPayloadCodec maxBound) =<< decodeB64UrlNoPaddingText t
  in unsafePerformIO $ mapM decodeTx [
    "eyJoYXNoIjoiOGJXY0xlSzFSYUZYVGVLbnhzQ2tuWW5QcnAza29vX0cxTk05eHl0VmFjVSIsInNpZ3MiOltdLCJjbWQiOiJ7XCJuZXR3b3JrSWRcIjpudWxsLFwicGF5bG9hZFwiOntcImV4ZWNcIjp7XCJkYXRhXCI6bnVsbCxcImNvZGVcIjpcIlxcbihtb2R1bGUgY29pbiBHT1ZFUk5BTkNFXFxuXFxuICBAZG9jIFxcXCInY29pbicgcmVwcmVzZW50cyB0aGUgS2FkZW5hIENvaW4gQ29udHJhY3QuIFRoaXMgY29udHJhY3QgcHJvdmlkZXMgYm90aCB0aGUgXFxcXFxcbiAgXFxcXGJ1eS9yZWRlZW0gZ2FzIHN1cHBvcnQgaW4gdGhlIGZvcm0gb2YgJ2Z1bmQtdHgnLCBhcyB3ZWxsIGFzIHRyYW5zZmVyLCAgICAgICBcXFxcXFxuICBcXFxcY3JlZGl0LCBkZWJpdCwgY29pbmJhc2UsIGFjY291bnQgY3JlYXRpb24gYW5kIHF1ZXJ5LCBhcyB3ZWxsIGFzIFNQViBidXJuICAgIFxcXFxcXG4gIFxcXFxjcmVhdGUuIFRvIGFjY2VzcyB0aGUgY29pbiBjb250cmFjdCwgeW91IG1heSB1c2UgaXRzIGZ1bGx5LXF1YWxpZmllZCBuYW1lLCAgXFxcXFxcbiAgXFxcXG9yIGlzc3VlIHRoZSAnKHVzZSBjb2luKScgY29tbWFuZCBpbiB0aGUgYm9keSBvZiBhIG1vZHVsZSBkZWNsYXJhdGlvbi5cXFwiXFxuXFxuICBAbW9kZWxcXG4gICAgWyAoZGVmcHJvcGVydHkgY29uc2VydmVzLW1hc3NcXG4gICAgICAgICg9IChjb2x1bW4tZGVsdGEgY29pbi10YWJsZSAnYmFsYW5jZSkgMC4wKSlcXG5cXG4gICAgICAoZGVmcHJvcGVydHkgdmFsaWQtYWNjb3VudCAoYWNjb3VudDpzdHJpbmcpXFxuICAgICAgICAoYW5kXFxuICAgICAgICAgICg-PSAobGVuZ3RoIGFjY291bnQpIDMpXFxuICAgICAgICAgICg8PSAobGVuZ3RoIGFjY291bnQpIDI1NikpKVxcbiAgICBdXFxuXFxuICAoaW1wbGVtZW50cyBmdW5naWJsZS12MilcXG4gIChpbXBsZW1lbnRzIGZ1bmdpYmxlLXhjaGFpbi12MSlcXG5cXG4gIDs7IGNvaW4tdjJcXG4gIChibGVzcyBcXFwidXRfSl9aTmtveWFQVUVKaGl3VmVXbmtTUW45SlQ5c1FDV0tkampWVnJXb1xcXCIpXFxuXFxuICA7OyBjb2luIHYzXFxuICAoYmxlc3MgXFxcIjFvc19zTEFVWXZCenNwbjVqamF3dFJwSldpSDFXUGZoeU5yYWVWdlNJd1VcXFwiKVxcblxcbiAgOzsgY29pbiB2NFxcbiAgKGJsZXNzIFxcXCJCalpXMFQyYWM2cUVfSTVYOEdFNGZhbDZ0VHFqaExUQzdteTB5dFFTeExVXFxcIilcXG5cXG4gIDs7IGNvaW4gdjVcXG4gIChibGVzcyBcXFwickU3RFU4amxRTDl4X01QWXVuaVpKZjVJQ0JUQUVIQUlGUUNCNGJsb2ZQNFxcXCIpXFxuXFxuICA7IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXFxuICA7IFNjaGVtYXMgYW5kIFRhYmxlc1xcblxcbiAgKGRlZnNjaGVtYSBjb2luLXNjaGVtYVxcbiAgICBAZG9jIFxcXCJUaGUgY29pbiBjb250cmFjdCB0b2tlbiBzY2hlbWFcXFwiXFxuICAgIEBtb2RlbCBbIChpbnZhcmlhbnQgKD49IGJhbGFuY2UgMC4wKSkgXVxcblxcbiAgICBiYWxhbmNlOmRlY2ltYWxcXG4gICAgZ3VhcmQ6Z3VhcmQpXFxuXFxuICAoZGVmdGFibGUgY29pbi10YWJsZTp7Y29pbi1zY2hlbWF9KVxcblxcbiAgOyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxcbiAgOyBDYXBhYmlsaXRpZXNcXG5cXG4gIChkZWZjYXAgR09WRVJOQU5DRSAoKVxcbiAgICAoZW5mb3JjZSBmYWxzZSBcXFwiRW5mb3JjZSBub24tdXBncmFkZWFiaWxpdHlcXFwiKSlcXG5cXG4gIChkZWZjYXAgR0FTICgpXFxuICAgIFxcXCJNYWdpYyBjYXBhYmlsaXR5IHRvIHByb3RlY3QgZ2FzIGJ1eSBhbmQgcmVkZWVtXFxcIlxcbiAgICB0cnVlKVxcblxcbiAgKGRlZmNhcCBDT0lOQkFTRSAoKVxcbiAgICBcXFwiTWFnaWMgY2FwYWJpbGl0eSB0byBwcm90ZWN0IG1pbmVyIHJld2FyZFxcXCJcXG4gICAgdHJ1ZSlcXG5cXG4gIChkZWZjYXAgR0VORVNJUyAoKVxcbiAgICBcXFwiTWFnaWMgY2FwYWJpbGl0eSBjb25zdHJhaW5pbmcgZ2VuZXNpcyB0cmFuc2FjdGlvbnNcXFwiXFxuICAgIHRydWUpXFxuXFxuICAoZGVmY2FwIFJFTUVESUFURSAoKVxcbiAgICBcXFwiTWFnaWMgY2FwYWJpbGl0eSBmb3IgcmVtZWRpYXRpb24gdHJhbnNhY3Rpb25zXFxcIlxcbiAgICB0cnVlKVxcblxcbiAgKGRlZmNhcCBERUJJVCAoc2VuZGVyOnN0cmluZylcXG4gICAgXFxcIkNhcGFiaWxpdHkgZm9yIG1hbmFnaW5nIGRlYml0aW5nIG9wZXJhdGlvbnNcXFwiXFxuICAgIChlbmZvcmNlLWd1YXJkIChhdCAnZ3VhcmQgKHJlYWQgY29pbi10YWJsZSBzZW5kZXIpKSlcXG4gICAgKGVuZm9yY2UgKCE9IHNlbmRlciBcXFwiXFxcIikgXFxcInZhbGlkIHNlbmRlclxcXCIpKVxcblxcbiAgKGRlZmNhcCBDUkVESVQgKHJlY2VpdmVyOnN0cmluZylcXG4gICAgXFxcIkNhcGFiaWxpdHkgZm9yIG1hbmFnaW5nIGNyZWRpdGluZyBvcGVyYXRpb25zXFxcIlxcbiAgICAoZW5mb3JjZSAoIT0gcmVjZWl2ZXIgXFxcIlxcXCIpIFxcXCJ2YWxpZCByZWNlaXZlclxcXCIpKVxcblxcbiAgKGRlZmNhcCBST1RBVEUgKGFjY291bnQ6c3RyaW5nKVxcbiAgICBAZG9jIFxcXCJBdXRvbm9tb3VzbHkgbWFuYWdlZCBjYXBhYmlsaXR5IGZvciBndWFyZCByb3RhdGlvblxcXCJcXG4gICAgQG1hbmFnZWRcXG4gICAgdHJ1ZSlcXG5cXG4gIChkZWZjYXAgVFJBTlNGRVI6Ym9vbFxcbiAgICAoIHNlbmRlcjpzdHJpbmdcXG4gICAgICByZWNlaXZlcjpzdHJpbmdcXG4gICAgICBhbW91bnQ6ZGVjaW1hbFxcbiAgICApXFxuICAgIEBtYW5hZ2VkIGFtb3VudCBUUkFOU0ZFUi1tZ3JcXG4gICAgKGVuZm9yY2UgKCE9IHNlbmRlciByZWNlaXZlcikgXFxcInNhbWUgc2VuZGVyIGFuZCByZWNlaXZlclxcXCIpXFxuICAgIChlbmZvcmNlLXVuaXQgYW1vdW50KVxcbiAgICAoZW5mb3JjZSAoPiBhbW91bnQgMC4wKSBcXFwiUG9zaXRpdmUgYW1vdW50XFxcIilcXG4gICAgKGNvbXBvc2UtY2FwYWJpbGl0eSAoREVCSVQgc2VuZGVyKSlcXG4gICAgKGNvbXBvc2UtY2FwYWJpbGl0eSAoQ1JFRElUIHJlY2VpdmVyKSlcXG4gIClcXG5cXG4gIChkZWZ1biBUUkFOU0ZFUi1tZ3I6ZGVjaW1hbFxcbiAgICAoIG1hbmFnZWQ6ZGVjaW1hbFxcbiAgICAgIHJlcXVlc3RlZDpkZWNpbWFsXFxuICAgIClcXG5cXG4gICAgKGxldCAoKG5ld2JhbCAoLSBtYW5hZ2VkIHJlcXVlc3RlZCkpKVxcbiAgICAgIChlbmZvcmNlICg-PSBuZXdiYWwgMC4wKVxcbiAgICAgICAgKGZvcm1hdCBcXFwiVFJBTlNGRVIgZXhjZWVkZWQgZm9yIGJhbGFuY2Uge31cXFwiIFttYW5hZ2VkXSkpXFxuICAgICAgbmV3YmFsKVxcbiAgKVxcblxcbiAgKGRlZmNhcCBUUkFOU0ZFUl9YQ0hBSU46Ym9vbFxcbiAgICAoIHNlbmRlcjpzdHJpbmdcXG4gICAgICByZWNlaXZlcjpzdHJpbmdcXG4gICAgICBhbW91bnQ6ZGVjaW1hbFxcbiAgICAgIHRhcmdldC1jaGFpbjpzdHJpbmdcXG4gICAgKVxcblxcbiAgICBAbWFuYWdlZCBhbW91bnQgVFJBTlNGRVJfWENIQUlOLW1nclxcbiAgICAoZW5mb3JjZS11bml0IGFtb3VudClcXG4gICAgKGVuZm9yY2UgKD4gYW1vdW50IDAuMCkgXFxcIkNyb3NzLWNoYWluIHRyYW5zZmVycyByZXF1aXJlIGEgcG9zaXRpdmUgYW1vdW50XFxcIilcXG4gICAgKGNvbXBvc2UtY2FwYWJpbGl0eSAoREVCSVQgc2VuZGVyKSlcXG4gIClcXG5cXG4gIChkZWZ1biBUUkFOU0ZFUl9YQ0hBSU4tbWdyOmRlY2ltYWxcXG4gICAgKCBtYW5hZ2VkOmRlY2ltYWxcXG4gICAgICByZXF1ZXN0ZWQ6ZGVjaW1hbFxcbiAgICApXFxuXFxuICAgIChlbmZvcmNlICg-PSBtYW5hZ2VkIHJlcXVlc3RlZClcXG4gICAgICAoZm9ybWF0IFxcXCJUUkFOU0ZFUl9YQ0hBSU4gZXhjZWVkZWQgZm9yIGJhbGFuY2Uge31cXFwiIFttYW5hZ2VkXSkpXFxuICAgIDAuMFxcbiAgKVxcblxcbiAgKGRlZmNhcCBUUkFOU0ZFUl9YQ0hBSU5fUkVDRDpib29sXFxuICAgICggc2VuZGVyOnN0cmluZ1xcbiAgICAgIHJlY2VpdmVyOnN0cmluZ1xcbiAgICAgIGFtb3VudDpkZWNpbWFsXFxuICAgICAgc291cmNlLWNoYWluOnN0cmluZ1xcbiAgICApXFxuICAgIEBldmVudCB0cnVlXFxuICApXFxuXFxuICA7IHYzIGNhcGFiaWxpdGllc1xcbiAgKGRlZmNhcCBSRUxFQVNFX0FMTE9DQVRJT05cXG4gICAgKCBhY2NvdW50OnN0cmluZ1xcbiAgICAgIGFtb3VudDpkZWNpbWFsXFxuICAgIClcXG4gICAgQGRvYyBcXFwiRXZlbnQgZm9yIGFsbG9jYXRpb24gcmVsZWFzZSwgY2FuIGJlIHVzZWQgZm9yIHNpZyBzY29waW5nLlxcXCJcXG4gICAgQGV2ZW50IHRydWVcXG4gIClcXG5cXG4gIDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cXG4gIDsgQ29uc3RhbnRzXFxuXFxuICAoZGVmY29uc3QgQ09JTl9DSEFSU0VUIENIQVJTRVRfTEFUSU4xXFxuICAgIFxcXCJUaGUgZGVmYXVsdCBjb2luIGNvbnRyYWN0IGNoYXJhY3RlciBzZXRcXFwiKVxcblxcbiAgKGRlZmNvbnN0IE1JTklNVU1fUFJFQ0lTSU9OIDEyXFxuICAgIFxcXCJNaW5pbXVtIGFsbG93ZWQgcHJlY2lzaW9uIGZvciBjb2luIHRyYW5zYWN0aW9uc1xcXCIpXFxuXFxuICAoZGVmY29uc3QgTUlOSU1VTV9BQ0NPVU5UX0xFTkdUSCAzXFxuICAgIFxcXCJNaW5pbXVtIGFjY291bnQgbGVuZ3RoIGFkbWlzc2libGUgZm9yIGNvaW4gYWNjb3VudHNcXFwiKVxcblxcbiAgKGRlZmNvbnN0IE1BWElNVU1fQUNDT1VOVF9MRU5HVEggMjU2XFxuICAgIFxcXCJNYXhpbXVtIGFjY291bnQgbmFtZSBsZW5ndGggYWRtaXNzaWJsZSBmb3IgY29pbiBhY2NvdW50c1xcXCIpXFxuXFxuICAoZGVmY29uc3QgVkFMSURfQ0hBSU5fSURTIChtYXAgKGludC10by1zdHIgMTApIChlbnVtZXJhdGUgMCAxOSkpXFxuICAgIFxcXCJMaXN0IG9mIGFsbCB2YWxpZCBDaGFpbndlYiBjaGFpbiBpZHNcXFwiKVxcblxcbiAgOyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxcbiAgOyBVdGlsaXRpZXNcXG5cXG4gIChkZWZ1biBlbmZvcmNlLXVuaXQ6Ym9vbCAoYW1vdW50OmRlY2ltYWwpXFxuICAgIEBkb2MgXFxcIkVuZm9yY2UgbWluaW11bSBwcmVjaXNpb24gYWxsb3dlZCBmb3IgY29pbiB0cmFuc2FjdGlvbnNcXFwiXFxuXFxuICAgIChlbmZvcmNlXFxuICAgICAgKD0gKGZsb29yIGFtb3VudCBNSU5JTVVNX1BSRUNJU0lPTilcXG4gICAgICAgICBhbW91bnQpXFxuICAgICAgKGZvcm1hdCBcXFwiQW1vdW50IHZpb2xhdGVzIG1pbmltdW0gcHJlY2lzaW9uOiB7fVxcXCIgW2Ftb3VudF0pKVxcbiAgICApXFxuXFxuICAoZGVmdW4gdmFsaWRhdGUtYWNjb3VudCAoYWNjb3VudDpzdHJpbmcpXFxuICAgIEBkb2MgXFxcIkVuZm9yY2UgdGhhdCBhbiBhY2NvdW50IG5hbWUgY29uZm9ybXMgdG8gdGhlIGNvaW4gY29udHJhY3QgXFxcXFxcbiAgICAgICAgIFxcXFxtaW5pbXVtIGFuZCBtYXhpbXVtIGxlbmd0aCByZXF1aXJlbWVudHMsIGFzIHdlbGwgYXMgdGhlICAgIFxcXFxcXG4gICAgICAgICBcXFxcbGF0aW4tMSBjaGFyYWN0ZXIgc2V0LlxcXCJcXG5cXG4gICAgKGVuZm9yY2VcXG4gICAgICAoaXMtY2hhcnNldCBDT0lOX0NIQVJTRVQgYWNjb3VudClcXG4gICAgICAoZm9ybWF0XFxuICAgICAgICBcXFwiQWNjb3VudCBkb2VzIG5vdCBjb25mb3JtIHRvIHRoZSBjb2luIGNvbnRyYWN0IGNoYXJzZXQ6IHt9XFxcIlxcbiAgICAgICAgW2FjY291bnRdKSlcXG5cXG4gICAgKGxldCAoKGFjY291bnQtbGVuZ3RoIChsZW5ndGggYWNjb3VudCkpKVxcblxcbiAgICAgIChlbmZvcmNlXFxuICAgICAgICAoPj0gYWNjb3VudC1sZW5ndGggTUlOSU1VTV9BQ0NPVU5UX0xFTkdUSClcXG4gICAgICAgIChmb3JtYXRcXG4gICAgICAgICAgXFxcIkFjY291bnQgbmFtZSBkb2VzIG5vdCBjb25mb3JtIHRvIHRoZSBtaW4gbGVuZ3RoIHJlcXVpcmVtZW50OiB7fVxcXCJcXG4gICAgICAgICAgW2FjY291bnRdKSlcXG5cXG4gICAgICAoZW5mb3JjZVxcbiAgICAgICAgKDw9IGFjY291bnQtbGVuZ3RoIE1BWElNVU1fQUNDT1VOVF9MRU5HVEgpXFxuICAgICAgICAoZm9ybWF0XFxuICAgICAgICAgIFxcXCJBY2NvdW50IG5hbWUgZG9lcyBub3QgY29uZm9ybSB0byB0aGUgbWF4IGxlbmd0aCByZXF1aXJlbWVudDoge31cXFwiXFxuICAgICAgICAgIFthY2NvdW50XSkpXFxuICAgICAgKVxcbiAgKVxcblxcbiAgOyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxcbiAgOyBDb2luIENvbnRyYWN0XFxuXFxuICAoZGVmdW4gZ2FzLW9ubHkgKClcXG4gICAgXFxcIlByZWRpY2F0ZSBmb3IgZ2FzLW9ubHkgdXNlciBndWFyZHMuXFxcIlxcbiAgICAocmVxdWlyZS1jYXBhYmlsaXR5IChHQVMpKSlcXG5cXG4gIChkZWZ1biBnYXMtZ3VhcmQgKGd1YXJkOmd1YXJkKVxcbiAgICBcXFwiUHJlZGljYXRlIGZvciBnYXMgKyBzaW5nbGUga2V5IHVzZXIgZ3VhcmRzXFxcIlxcbiAgICAoZW5mb3JjZS1vbmVcXG4gICAgICBcXFwiRW5mb3JjZSBlaXRoZXIgdGhlIHByZXNlbmNlIG9mIGEgR0FTIGNhcCBvciBrZXlzZXRcXFwiXFxuICAgICAgWyAoZ2FzLW9ubHkpXFxuICAgICAgICAoZW5mb3JjZS1ndWFyZCBndWFyZClcXG4gICAgICBdKSlcXG5cXG4gIChkZWZ1biBidXktZ2FzOnN0cmluZyAoc2VuZGVyOnN0cmluZyB0b3RhbDpkZWNpbWFsKVxcbiAgICBAZG9jIFxcXCJUaGlzIGZ1bmN0aW9uIGRlc2NyaWJlcyB0aGUgbWFpbiAnZ2FzIGJ1eScgb3BlcmF0aW9uLiBBdCB0aGlzIHBvaW50IFxcXFxcXG4gICAgXFxcXE1JTkVSIGhhcyBiZWVuIGNob3NlbiBmcm9tIHRoZSBwb29sLCBhbmQgd2lsbCBiZSB2YWxpZGF0ZWQuIFRoZSBTRU5ERVIgICBcXFxcXFxuICAgIFxcXFxvZiB0aGlzIHRyYW5zYWN0aW9uIGhhcyBzcGVjaWZpZWQgYSBnYXMgbGltaXQgTElNSVQgKG1heGltdW0gZ2FzKSBmb3IgICAgXFxcXFxcbiAgICBcXFxcdGhlIHRyYW5zYWN0aW9uLCBhbmQgdGhlIHByaWNlIGlzIHRoZSBzcG90IHByaWNlIG9mIGdhcyBhdCB0aGF0IHRpbWUuICAgIFxcXFxcXG4gICAgXFxcXFRoZSBnYXMgYnV5IHdpbGwgYmUgZXhlY3V0ZWQgcHJpb3IgdG8gZXhlY3V0aW5nIFNFTkRFUidzIGNvZGUuXFxcIlxcblxcbiAgICBAbW9kZWwgWyAocHJvcGVydHkgKD4gdG90YWwgMC4wKSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IHNlbmRlcikpXFxuICAgICAgICAgICBdXFxuXFxuICAgICh2YWxpZGF0ZS1hY2NvdW50IHNlbmRlcilcXG5cXG4gICAgKGVuZm9yY2UtdW5pdCB0b3RhbClcXG4gICAgKGVuZm9yY2UgKD4gdG90YWwgMC4wKSBcXFwiZ2FzIHN1cHBseSBtdXN0IGJlIGEgcG9zaXRpdmUgcXVhbnRpdHlcXFwiKVxcblxcbiAgICAocmVxdWlyZS1jYXBhYmlsaXR5IChHQVMpKVxcbiAgICAod2l0aC1jYXBhYmlsaXR5IChERUJJVCBzZW5kZXIpXFxuICAgICAgKGRlYml0IHNlbmRlciB0b3RhbCkpXFxuICAgIClcXG5cXG4gIChkZWZ1biByZWRlZW0tZ2FzOnN0cmluZyAobWluZXI6c3RyaW5nIG1pbmVyLWd1YXJkOmd1YXJkIHNlbmRlcjpzdHJpbmcgdG90YWw6ZGVjaW1hbClcXG4gICAgQGRvYyBcXFwiVGhpcyBmdW5jdGlvbiBkZXNjcmliZXMgdGhlIG1haW4gJ3JlZGVlbSBnYXMnIG9wZXJhdGlvbi4gQXQgdGhpcyAgICBcXFxcXFxuICAgIFxcXFxwb2ludCwgdGhlIFNFTkRFUidzIHRyYW5zYWN0aW9uIGhhcyBiZWVuIGV4ZWN1dGVkLCBhbmQgdGhlIGdhcyB0aGF0ICAgICAgXFxcXFxcbiAgICBcXFxcd2FzIGNoYXJnZWQgaGFzIGJlZW4gY2FsY3VsYXRlZC4gTUlORVIgd2lsbCBiZSBjcmVkaXRlZCB0aGUgZ2FzIGNvc3QsICAgIFxcXFxcXG4gICAgXFxcXGFuZCBTRU5ERVIgd2lsbCByZWNlaXZlIHRoZSByZW1haW5kZXIgdXAgdG8gdGhlIGxpbWl0XFxcIlxcblxcbiAgICBAbW9kZWwgWyAocHJvcGVydHkgKD4gdG90YWwgMC4wKSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IHNlbmRlcikpXFxuICAgICAgICAgICAgIChwcm9wZXJ0eSAodmFsaWQtYWNjb3VudCBtaW5lcikpXFxuICAgICAgICAgICBdXFxuXFxuICAgICh2YWxpZGF0ZS1hY2NvdW50IHNlbmRlcilcXG4gICAgKHZhbGlkYXRlLWFjY291bnQgbWluZXIpXFxuICAgIChlbmZvcmNlLXVuaXQgdG90YWwpXFxuXFxuICAgIChyZXF1aXJlLWNhcGFiaWxpdHkgKEdBUykpXFxuICAgIChsZXQqXFxuICAgICAgKChmZWUgKHJlYWQtZGVjaW1hbCBcXFwiZmVlXFxcIikpXFxuICAgICAgIChyZWZ1bmQgKC0gdG90YWwgZmVlKSkpXFxuXFxuICAgICAgKGVuZm9yY2UtdW5pdCBmZWUpXFxuICAgICAgKGVuZm9yY2UgKD49IGZlZSAwLjApXFxuICAgICAgICBcXFwiZmVlIG11c3QgYmUgYSBub24tbmVnYXRpdmUgcXVhbnRpdHlcXFwiKVxcblxcbiAgICAgIChlbmZvcmNlICg-PSByZWZ1bmQgMC4wKVxcbiAgICAgICAgXFxcInJlZnVuZCBtdXN0IGJlIGEgbm9uLW5lZ2F0aXZlIHF1YW50aXR5XFxcIilcXG5cXG4gICAgICAoZW1pdC1ldmVudCAoVFJBTlNGRVIgc2VuZGVyIG1pbmVyIGZlZSkpIDt2M1xcblxcbiAgICAgICAgOyBkaXJlY3RseSB1cGRhdGUgaW5zdGVhZCBvZiBjcmVkaXRcXG4gICAgICAod2l0aC1jYXBhYmlsaXR5IChDUkVESVQgc2VuZGVyKVxcbiAgICAgICAgKGlmICg-IHJlZnVuZCAwLjApXFxuICAgICAgICAgICh3aXRoLXJlYWQgY29pbi10YWJsZSBzZW5kZXJcXG4gICAgICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6PSBiYWxhbmNlIH1cXG4gICAgICAgICAgICAodXBkYXRlIGNvaW4tdGFibGUgc2VuZGVyXFxuICAgICAgICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIjogKCsgYmFsYW5jZSByZWZ1bmQpIH0pKVxcblxcbiAgICAgICAgICBcXFwibm9vcFxcXCIpKVxcblxcbiAgICAgICh3aXRoLWNhcGFiaWxpdHkgKENSRURJVCBtaW5lcilcXG4gICAgICAgIChpZiAoPiBmZWUgMC4wKVxcbiAgICAgICAgICAoY3JlZGl0IG1pbmVyIG1pbmVyLWd1YXJkIGZlZSlcXG4gICAgICAgICAgXFxcIm5vb3BcXFwiKSlcXG4gICAgICApXFxuXFxuICAgIClcXG5cXG4gIChkZWZ1biBjcmVhdGUtYWNjb3VudDpzdHJpbmcgKGFjY291bnQ6c3RyaW5nIGd1YXJkOmd1YXJkKVxcbiAgICBAbW9kZWwgWyAocHJvcGVydHkgKHZhbGlkLWFjY291bnQgYWNjb3VudCkpIF1cXG5cXG4gICAgKHZhbGlkYXRlLWFjY291bnQgYWNjb3VudClcXG4gICAgKGVuZm9yY2UtcmVzZXJ2ZWQgYWNjb3VudCBndWFyZClcXG5cXG4gICAgKGluc2VydCBjb2luLXRhYmxlIGFjY291bnRcXG4gICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6IDAuMFxcbiAgICAgICwgXFxcImd1YXJkXFxcIiAgIDogZ3VhcmRcXG4gICAgICB9KVxcbiAgICApXFxuXFxuICAoZGVmdW4gZ2V0LWJhbGFuY2U6ZGVjaW1hbCAoYWNjb3VudDpzdHJpbmcpXFxuICAgICh3aXRoLXJlYWQgY29pbi10YWJsZSBhY2NvdW50XFxuICAgICAgeyBcXFwiYmFsYW5jZVxcXCIgOj0gYmFsYW5jZSB9XFxuICAgICAgYmFsYW5jZVxcbiAgICAgIClcXG4gICAgKVxcblxcbiAgKGRlZnVuIGRldGFpbHM6b2JqZWN0e2Z1bmdpYmxlLXYyLmFjY291bnQtZGV0YWlsc31cXG4gICAgKCBhY2NvdW50OnN0cmluZyApXFxuICAgICh3aXRoLXJlYWQgY29pbi10YWJsZSBhY2NvdW50XFxuICAgICAgeyBcXFwiYmFsYW5jZVxcXCIgOj0gYmFsXFxuICAgICAgLCBcXFwiZ3VhcmRcXFwiIDo9IGcgfVxcbiAgICAgIHsgXFxcImFjY291bnRcXFwiIDogYWNjb3VudFxcbiAgICAgICwgXFxcImJhbGFuY2VcXFwiIDogYmFsXFxuICAgICAgLCBcXFwiZ3VhcmRcXFwiOiBnIH0pXFxuICAgIClcXG5cXG4gIChkZWZ1biByb3RhdGU6c3RyaW5nIChhY2NvdW50OnN0cmluZyBuZXctZ3VhcmQ6Z3VhcmQpXFxuICAgICh3aXRoLWNhcGFiaWxpdHkgKFJPVEFURSBhY2NvdW50KVxcblxcbiAgICAgIDsgQWxsb3cgcm90YXRpb24gb25seSBmb3IgdmFuaXR5IGFjY291bnRzLCBvclxcbiAgICAgIDsgcmUtcm90YXRpbmcgYSBwcmluY2lwYWwgYWNjb3VudCBiYWNrIHRvIGl0cyBwcm9wZXIgZ3VhcmRcXG4gICAgICAoZW5mb3JjZSAob3IgKG5vdCAoaXMtcHJpbmNpcGFsIGFjY291bnQpKVxcbiAgICAgICAgICAgICAgICAgICh2YWxpZGF0ZS1wcmluY2lwYWwgbmV3LWd1YXJkIGFjY291bnQpKVxcbiAgICAgICAgXFxcIkl0IGlzIHVuc2FmZSBmb3IgcHJpbmNpcGFsIGFjY291bnRzIHRvIHJvdGF0ZSB0aGVpciBndWFyZFxcXCIpXFxuXFxuICAgICAgKHdpdGgtcmVhZCBjb2luLXRhYmxlIGFjY291bnRcXG4gICAgICAgIHsgXFxcImd1YXJkXFxcIiA6PSBvbGQtZ3VhcmQgfVxcbiAgICAgICAgKGVuZm9yY2UtZ3VhcmQgb2xkLWd1YXJkKVxcbiAgICAgICAgKHVwZGF0ZSBjb2luLXRhYmxlIGFjY291bnRcXG4gICAgICAgICAgeyBcXFwiZ3VhcmRcXFwiIDogbmV3LWd1YXJkIH1cXG4gICAgICAgICAgKSkpXFxuICAgIClcXG5cXG5cXG4gIChkZWZ1biBwcmVjaXNpb246aW50ZWdlclxcbiAgICAoKVxcbiAgICBNSU5JTVVNX1BSRUNJU0lPTilcXG5cXG4gIChkZWZ1biB0cmFuc2ZlcjpzdHJpbmcgKHNlbmRlcjpzdHJpbmcgcmVjZWl2ZXI6c3RyaW5nIGFtb3VudDpkZWNpbWFsKVxcbiAgICBAbW9kZWwgWyAocHJvcGVydHkgY29uc2VydmVzLW1hc3MpXFxuICAgICAgICAgICAgIChwcm9wZXJ0eSAoPiBhbW91bnQgMC4wKSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IHNlbmRlcikpXFxuICAgICAgICAgICAgIChwcm9wZXJ0eSAodmFsaWQtYWNjb3VudCByZWNlaXZlcikpXFxuICAgICAgICAgICAgIChwcm9wZXJ0eSAoIT0gc2VuZGVyIHJlY2VpdmVyKSkgXVxcblxcbiAgICAoZW5mb3JjZSAoIT0gc2VuZGVyIHJlY2VpdmVyKVxcbiAgICAgIFxcXCJzZW5kZXIgY2Fubm90IGJlIHRoZSByZWNlaXZlciBvZiBhIHRyYW5zZmVyXFxcIilcXG5cXG4gICAgKHZhbGlkYXRlLWFjY291bnQgc2VuZGVyKVxcbiAgICAodmFsaWRhdGUtYWNjb3VudCByZWNlaXZlcilcXG5cXG4gICAgKGVuZm9yY2UgKD4gYW1vdW50IDAuMClcXG4gICAgICBcXFwidHJhbnNmZXIgYW1vdW50IG11c3QgYmUgcG9zaXRpdmVcXFwiKVxcblxcbiAgICAoZW5mb3JjZS11bml0IGFtb3VudClcXG5cXG4gICAgKHdpdGgtY2FwYWJpbGl0eSAoVFJBTlNGRVIgc2VuZGVyIHJlY2VpdmVyIGFtb3VudClcXG4gICAgICAoZGViaXQgc2VuZGVyIGFtb3VudClcXG4gICAgICAod2l0aC1yZWFkIGNvaW4tdGFibGUgcmVjZWl2ZXJcXG4gICAgICAgIHsgXFxcImd1YXJkXFxcIiA6PSBnIH1cXG5cXG4gICAgICAgIChjcmVkaXQgcmVjZWl2ZXIgZyBhbW91bnQpKVxcbiAgICAgIClcXG4gICAgKVxcblxcbiAgKGRlZnVuIHRyYW5zZmVyLWNyZWF0ZTpzdHJpbmdcXG4gICAgKCBzZW5kZXI6c3RyaW5nXFxuICAgICAgcmVjZWl2ZXI6c3RyaW5nXFxuICAgICAgcmVjZWl2ZXItZ3VhcmQ6Z3VhcmRcXG4gICAgICBhbW91bnQ6ZGVjaW1hbCApXFxuXFxuICAgIEBtb2RlbCBbIChwcm9wZXJ0eSBjb25zZXJ2ZXMtbWFzcykgXVxcblxcbiAgICAoZW5mb3JjZSAoIT0gc2VuZGVyIHJlY2VpdmVyKVxcbiAgICAgIFxcXCJzZW5kZXIgY2Fubm90IGJlIHRoZSByZWNlaXZlciBvZiBhIHRyYW5zZmVyXFxcIilcXG5cXG4gICAgKHZhbGlkYXRlLWFjY291bnQgc2VuZGVyKVxcbiAgICAodmFsaWRhdGUtYWNjb3VudCByZWNlaXZlcilcXG5cXG4gICAgKGVuZm9yY2UgKD4gYW1vdW50IDAuMClcXG4gICAgICBcXFwidHJhbnNmZXIgYW1vdW50IG11c3QgYmUgcG9zaXRpdmVcXFwiKVxcblxcbiAgICAoZW5mb3JjZS11bml0IGFtb3VudClcXG5cXG4gICAgKHdpdGgtY2FwYWJpbGl0eSAoVFJBTlNGRVIgc2VuZGVyIHJlY2VpdmVyIGFtb3VudClcXG4gICAgICAoZGViaXQgc2VuZGVyIGFtb3VudClcXG4gICAgICAoY3JlZGl0IHJlY2VpdmVyIHJlY2VpdmVyLWd1YXJkIGFtb3VudCkpXFxuICAgIClcXG5cXG4gIChkZWZ1biBjb2luYmFzZTpzdHJpbmcgKGFjY291bnQ6c3RyaW5nIGFjY291bnQtZ3VhcmQ6Z3VhcmQgYW1vdW50OmRlY2ltYWwpXFxuICAgIEBkb2MgXFxcIkludGVybmFsIGZ1bmN0aW9uIGZvciB0aGUgaW5pdGlhbCBjcmVhdGlvbiBvZiBjb2lucy4gIFRoaXMgZnVuY3Rpb24gXFxcXFxcbiAgICBcXFxcY2Fubm90IGJlIHVzZWQgb3V0c2lkZSBvZiB0aGUgY29pbiBjb250cmFjdC5cXFwiXFxuXFxuICAgIEBtb2RlbCBbIChwcm9wZXJ0eSAodmFsaWQtYWNjb3VudCBhY2NvdW50KSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICg-IGFtb3VudCAwLjApKVxcbiAgICAgICAgICAgXVxcblxcbiAgICAodmFsaWRhdGUtYWNjb3VudCBhY2NvdW50KVxcbiAgICAoZW5mb3JjZS11bml0IGFtb3VudClcXG5cXG4gICAgKHJlcXVpcmUtY2FwYWJpbGl0eSAoQ09JTkJBU0UpKVxcbiAgICAoZW1pdC1ldmVudCAoVFJBTlNGRVIgXFxcIlxcXCIgYWNjb3VudCBhbW91bnQpKSA7djNcXG4gICAgKHdpdGgtY2FwYWJpbGl0eSAoQ1JFRElUIGFjY291bnQpXFxuICAgICAgKGNyZWRpdCBhY2NvdW50IGFjY291bnQtZ3VhcmQgYW1vdW50KSlcXG4gICAgKVxcblxcbiAgKGRlZnVuIHJlbWVkaWF0ZTpzdHJpbmcgKGFjY291bnQ6c3RyaW5nIGFtb3VudDpkZWNpbWFsKVxcbiAgICBAZG9jIFxcXCJBbGxvd3MgZm9yIHJlbWVkaWF0aW9uIHRyYW5zYWN0aW9ucy4gVGhpcyBmdW5jdGlvbiBcXFxcXFxuICAgICAgICAgXFxcXGlzIHByb3RlY3RlZCBieSB0aGUgUkVNRURJQVRFIGNhcGFiaWxpdHlcXFwiXFxuICAgIEBtb2RlbCBbIChwcm9wZXJ0eSAodmFsaWQtYWNjb3VudCBhY2NvdW50KSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICg-IGFtb3VudCAwLjApKVxcbiAgICAgICAgICAgXVxcblxcbiAgICAodmFsaWRhdGUtYWNjb3VudCBhY2NvdW50KVxcblxcbiAgICAoZW5mb3JjZSAoPiBhbW91bnQgMC4wKVxcbiAgICAgIFxcXCJSZW1lZGlhdGlvbiBhbW91bnQgbXVzdCBiZSBwb3NpdGl2ZVxcXCIpXFxuXFxuICAgIChlbmZvcmNlLXVuaXQgYW1vdW50KVxcblxcbiAgICAocmVxdWlyZS1jYXBhYmlsaXR5IChSRU1FRElBVEUpKVxcbiAgICAoZW1pdC1ldmVudCAoVFJBTlNGRVIgXFxcIlxcXCIgYWNjb3VudCBhbW91bnQpKSA7djNcXG4gICAgKHdpdGgtcmVhZCBjb2luLXRhYmxlIGFjY291bnRcXG4gICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6PSBiYWxhbmNlIH1cXG5cXG4gICAgICAoZW5mb3JjZSAoPD0gYW1vdW50IGJhbGFuY2UpIFxcXCJJbnN1ZmZpY2llbnQgZnVuZHNcXFwiKVxcblxcbiAgICAgICh1cGRhdGUgY29pbi10YWJsZSBhY2NvdW50XFxuICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6ICgtIGJhbGFuY2UgYW1vdW50KSB9XFxuICAgICAgICApKVxcbiAgICApXFxuXFxuICAoZGVmcGFjdCBmdW5kLXR4IChzZW5kZXI6c3RyaW5nIG1pbmVyOnN0cmluZyBtaW5lci1ndWFyZDpndWFyZCB0b3RhbDpkZWNpbWFsKVxcbiAgICBAZG9jIFxcXCInZnVuZC10eCcgaXMgYSBzcGVjaWFsIHBhY3QgdG8gZnVuZCBhIHRyYW5zYWN0aW9uIGluIHR3byBzdGVwcywgICAgIFxcXFxcXG4gICAgXFxcXHdpdGggdGhlIGFjdHVhbCB0cmFuc2FjdGlvbiB0cmFuc3BpcmluZyBpbiB0aGUgbWlkZGxlOiAgICAgICAgICAgICAgICAgICBcXFxcXFxuICAgIFxcXFwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXFxcXFxcbiAgICBcXFxcICAxKSBBIGJ1eWluZyBwaGFzZSwgZGViaXRpbmcgdGhlIHNlbmRlciBmb3IgdG90YWwgZ2FzIGFuZCBmZWUsIHlpZWxkaW5nIFxcXFxcXG4gICAgXFxcXCAgICAgVFhfTUFYX0NIQVJHRS4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcXFxcXFxuICAgIFxcXFwgIDIpIEEgc2V0dGxlbWVudCBwaGFzZSwgcmVzdW1pbmcgVFhfTUFYX0NIQVJHRSwgYW5kIGFsbG9jYXRpbmcgdG8gdGhlICAgXFxcXFxcbiAgICBcXFxcICAgICBjb2luYmFzZSBhY2NvdW50IGZvciB1c2VkIGdhcyBhbmQgZmVlLCBhbmQgc2VuZGVyIGFjY291bnQgZm9yIGJhbC0gIFxcXFxcXG4gICAgXFxcXCAgICAgYW5jZSAodW51c2VkIGdhcywgaWYgYW55KS5cXFwiXFxuXFxuICAgIEBtb2RlbCBbIChwcm9wZXJ0eSAoPiB0b3RhbCAwLjApKVxcbiAgICAgICAgICAgICAocHJvcGVydHkgKHZhbGlkLWFjY291bnQgc2VuZGVyKSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IG1pbmVyKSlcXG4gICAgICAgICAgICAgOyhwcm9wZXJ0eSBjb25zZXJ2ZXMtbWFzcykgbm90IHN1cHBvcnRlZCB5ZXRcXG4gICAgICAgICAgIF1cXG5cXG4gICAgKHN0ZXAgKGJ1eS1nYXMgc2VuZGVyIHRvdGFsKSlcXG4gICAgKHN0ZXAgKHJlZGVlbS1nYXMgbWluZXIgbWluZXItZ3VhcmQgc2VuZGVyIHRvdGFsKSlcXG4gICAgKVxcblxcbiAgKGRlZnVuIGRlYml0OnN0cmluZyAoYWNjb3VudDpzdHJpbmcgYW1vdW50OmRlY2ltYWwpXFxuICAgIEBkb2MgXFxcIkRlYml0IEFNT1VOVCBmcm9tIEFDQ09VTlQgYmFsYW5jZVxcXCJcXG5cXG4gICAgQG1vZGVsIFsgKHByb3BlcnR5ICg-IGFtb3VudCAwLjApKVxcbiAgICAgICAgICAgICAocHJvcGVydHkgKHZhbGlkLWFjY291bnQgYWNjb3VudCkpXFxuICAgICAgICAgICBdXFxuXFxuICAgICh2YWxpZGF0ZS1hY2NvdW50IGFjY291bnQpXFxuXFxuICAgIChlbmZvcmNlICg-IGFtb3VudCAwLjApXFxuICAgICAgXFxcImRlYml0IGFtb3VudCBtdXN0IGJlIHBvc2l0aXZlXFxcIilcXG5cXG4gICAgKGVuZm9yY2UtdW5pdCBhbW91bnQpXFxuXFxuICAgIChyZXF1aXJlLWNhcGFiaWxpdHkgKERFQklUIGFjY291bnQpKVxcbiAgICAod2l0aC1yZWFkIGNvaW4tdGFibGUgYWNjb3VudFxcbiAgICAgIHsgXFxcImJhbGFuY2VcXFwiIDo9IGJhbGFuY2UgfVxcblxcbiAgICAgIChlbmZvcmNlICg8PSBhbW91bnQgYmFsYW5jZSkgXFxcIkluc3VmZmljaWVudCBmdW5kc1xcXCIpXFxuXFxuICAgICAgKHVwZGF0ZSBjb2luLXRhYmxlIGFjY291bnRcXG4gICAgICAgIHsgXFxcImJhbGFuY2VcXFwiIDogKC0gYmFsYW5jZSBhbW91bnQpIH1cXG4gICAgICAgICkpXFxuICAgIClcXG5cXG5cXG4gIChkZWZ1biBjcmVkaXQ6c3RyaW5nIChhY2NvdW50OnN0cmluZyBndWFyZDpndWFyZCBhbW91bnQ6ZGVjaW1hbClcXG4gICAgQGRvYyBcXFwiQ3JlZGl0IEFNT1VOVCB0byBBQ0NPVU5UIGJhbGFuY2VcXFwiXFxuXFxuICAgIEBtb2RlbCBbIChwcm9wZXJ0eSAoPiBhbW91bnQgMC4wKSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IGFjY291bnQpKVxcbiAgICAgICAgICAgXVxcblxcbiAgICAodmFsaWRhdGUtYWNjb3VudCBhY2NvdW50KVxcblxcbiAgICAoZW5mb3JjZSAoPiBhbW91bnQgMC4wKSBcXFwiY3JlZGl0IGFtb3VudCBtdXN0IGJlIHBvc2l0aXZlXFxcIilcXG4gICAgKGVuZm9yY2UtdW5pdCBhbW91bnQpXFxuXFxuICAgIChyZXF1aXJlLWNhcGFiaWxpdHkgKENSRURJVCBhY2NvdW50KSlcXG4gICAgKHdpdGgtZGVmYXVsdC1yZWFkIGNvaW4tdGFibGUgYWNjb3VudFxcbiAgICAgIHsgXFxcImJhbGFuY2VcXFwiIDogLTEuMCwgXFxcImd1YXJkXFxcIiA6IGd1YXJkIH1cXG4gICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6PSBiYWxhbmNlLCBcXFwiZ3VhcmRcXFwiIDo9IHJldGcgfVxcbiAgICAgIDsgd2UgZG9uJ3Qgd2FudCB0byBvdmVyd3JpdGUgYW4gZXhpc3RpbmcgZ3VhcmQgd2l0aCB0aGUgdXNlci1zdXBwbGllZCBvbmVcXG4gICAgICAoZW5mb3JjZSAoPSByZXRnIGd1YXJkKVxcbiAgICAgICAgXFxcImFjY291bnQgZ3VhcmRzIGRvIG5vdCBtYXRjaFxcXCIpXFxuXFxuICAgICAgKGxldCAoKGlzLW5ld1xcbiAgICAgICAgICAgICAoaWYgKD0gYmFsYW5jZSAtMS4wKVxcbiAgICAgICAgICAgICAgICAgKGVuZm9yY2UtcmVzZXJ2ZWQgYWNjb3VudCBndWFyZClcXG4gICAgICAgICAgICAgICBmYWxzZSkpKVxcblxcbiAgICAgICAgKHdyaXRlIGNvaW4tdGFibGUgYWNjb3VudFxcbiAgICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6IChpZiBpcy1uZXcgYW1vdW50ICgrIGJhbGFuY2UgYW1vdW50KSlcXG4gICAgICAgICAgLCBcXFwiZ3VhcmRcXFwiICAgOiByZXRnXFxuICAgICAgICAgIH0pKVxcbiAgICAgICkpXFxuXFxuICAoZGVmdW4gY2hlY2stcmVzZXJ2ZWQ6c3RyaW5nIChhY2NvdW50OnN0cmluZylcXG4gICAgXFxcIiBDaGVja3MgQUNDT1VOVCBmb3IgcmVzZXJ2ZWQgbmFtZSBhbmQgcmV0dXJucyB0eXBlIGlmIFxcXFxcXG4gICAgXFxcXCBmb3VuZCBvciBlbXB0eSBzdHJpbmcuIFJlc2VydmVkIG5hbWVzIHN0YXJ0IHdpdGggYSBcXFxcXFxuICAgIFxcXFwgc2luZ2xlIGNoYXIgYW5kIGNvbG9uLCBlLmcuICdjOmZvbycsIHdoaWNoIHdvdWxkIHJldHVybiAnYycgYXMgdHlwZS5cXFwiXFxuICAgIChsZXQgKChwZnggKHRha2UgMiBhY2NvdW50KSkpXFxuICAgICAgKGlmICg9IFxcXCI6XFxcIiAodGFrZSAtMSBwZngpKSAodGFrZSAxIHBmeCkgXFxcIlxcXCIpKSlcXG5cXG4gIChkZWZ1biBlbmZvcmNlLXJlc2VydmVkOmJvb2wgKGFjY291bnQ6c3RyaW5nIGd1YXJkOmd1YXJkKVxcbiAgICBAZG9jIFxcXCJFbmZvcmNlIHJlc2VydmVkIGFjY291bnQgbmFtZSBwcm90b2NvbHMuXFxcIlxcbiAgICAoaWYgKHZhbGlkYXRlLXByaW5jaXBhbCBndWFyZCBhY2NvdW50KVxcbiAgICAgIHRydWVcXG4gICAgICAobGV0ICgociAoY2hlY2stcmVzZXJ2ZWQgYWNjb3VudCkpKVxcbiAgICAgICAgKGlmICg9IHIgXFxcIlxcXCIpXFxuICAgICAgICAgIHRydWVcXG4gICAgICAgICAgKGlmICg9IHIgXFxcImtcXFwiKVxcbiAgICAgICAgICAgIChlbmZvcmNlIGZhbHNlIFxcXCJTaW5nbGUta2V5IGFjY291bnQgcHJvdG9jb2wgdmlvbGF0aW9uXFxcIilcXG4gICAgICAgICAgICAoZW5mb3JjZSBmYWxzZVxcbiAgICAgICAgICAgICAgKGZvcm1hdCBcXFwiUmVzZXJ2ZWQgcHJvdG9jb2wgZ3VhcmQgdmlvbGF0aW9uOiB7fVxcXCIgW3JdKSlcXG4gICAgICAgICAgICApKSkpKVxcblxcblxcbiAgKGRlZnNjaGVtYSBjcm9zc2NoYWluLXNjaGVtYVxcbiAgICBAZG9jIFxcXCJTY2hlbWEgZm9yIHlpZWxkZWQgdmFsdWUgaW4gY3Jvc3MtY2hhaW4gdHJhbnNmZXJzXFxcIlxcbiAgICByZWNlaXZlcjpzdHJpbmdcXG4gICAgcmVjZWl2ZXItZ3VhcmQ6Z3VhcmRcXG4gICAgYW1vdW50OmRlY2ltYWxcXG4gICAgc291cmNlLWNoYWluOnN0cmluZylcXG5cXG4gIChkZWZwYWN0IHRyYW5zZmVyLWNyb3NzY2hhaW46c3RyaW5nXFxuICAgICggc2VuZGVyOnN0cmluZ1xcbiAgICAgIHJlY2VpdmVyOnN0cmluZ1xcbiAgICAgIHJlY2VpdmVyLWd1YXJkOmd1YXJkXFxuICAgICAgdGFyZ2V0LWNoYWluOnN0cmluZ1xcbiAgICAgIGFtb3VudDpkZWNpbWFsIClcXG5cXG4gICAgQG1vZGVsIFsgKHByb3BlcnR5ICg-IGFtb3VudCAwLjApKVxcbiAgICAgICAgICAgICAocHJvcGVydHkgKHZhbGlkLWFjY291bnQgc2VuZGVyKSlcXG4gICAgICAgICAgICAgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IHJlY2VpdmVyKSlcXG4gICAgICAgICAgIF1cXG5cXG4gICAgKHN0ZXBcXG4gICAgICAod2l0aC1jYXBhYmlsaXR5XFxuICAgICAgICAoVFJBTlNGRVJfWENIQUlOIHNlbmRlciByZWNlaXZlciBhbW91bnQgdGFyZ2V0LWNoYWluKVxcblxcbiAgICAgICAgKHZhbGlkYXRlLWFjY291bnQgc2VuZGVyKVxcbiAgICAgICAgKHZhbGlkYXRlLWFjY291bnQgcmVjZWl2ZXIpXFxuXFxuICAgICAgICAoZW5mb3JjZSAoIT0gXFxcIlxcXCIgdGFyZ2V0LWNoYWluKSBcXFwiZW1wdHkgdGFyZ2V0LWNoYWluXFxcIilcXG4gICAgICAgIChlbmZvcmNlICghPSAoYXQgJ2NoYWluLWlkIChjaGFpbi1kYXRhKSkgdGFyZ2V0LWNoYWluKVxcbiAgICAgICAgICBcXFwiY2Fubm90IHJ1biBjcm9zcy1jaGFpbiB0cmFuc2ZlcnMgdG8gdGhlIHNhbWUgY2hhaW5cXFwiKVxcblxcbiAgICAgICAgKGVuZm9yY2UgKD4gYW1vdW50IDAuMClcXG4gICAgICAgICAgXFxcInRyYW5zZmVyIHF1YW50aXR5IG11c3QgYmUgcG9zaXRpdmVcXFwiKVxcblxcbiAgICAgICAgKGVuZm9yY2UtdW5pdCBhbW91bnQpXFxuXFxuICAgICAgICAoZW5mb3JjZSAoY29udGFpbnMgdGFyZ2V0LWNoYWluIFZBTElEX0NIQUlOX0lEUylcXG4gICAgICAgICAgXFxcInRhcmdldCBjaGFpbiBpcyBub3QgYSB2YWxpZCBjaGFpbndlYiBjaGFpbiBpZFxcXCIpXFxuXFxuICAgICAgICA7OyBzdGVwIDEgLSBkZWJpdCBkZWxldGUtYWNjb3VudCBvbiBjdXJyZW50IGNoYWluXFxuICAgICAgICAoZGViaXQgc2VuZGVyIGFtb3VudClcXG4gICAgICAgIChlbWl0LWV2ZW50IChUUkFOU0ZFUiBzZW5kZXIgXFxcIlxcXCIgYW1vdW50KSlcXG5cXG4gICAgICAgIChsZXRcXG4gICAgICAgICAgKChjcm9zc2NoYWluLWRldGFpbHM6b2JqZWN0e2Nyb3NzY2hhaW4tc2NoZW1hfVxcbiAgICAgICAgICAgIHsgXFxcInJlY2VpdmVyXFxcIiA6IHJlY2VpdmVyXFxuICAgICAgICAgICAgLCBcXFwicmVjZWl2ZXItZ3VhcmRcXFwiIDogcmVjZWl2ZXItZ3VhcmRcXG4gICAgICAgICAgICAsIFxcXCJhbW91bnRcXFwiIDogYW1vdW50XFxuICAgICAgICAgICAgLCBcXFwic291cmNlLWNoYWluXFxcIiA6IChhdCAnY2hhaW4taWQgKGNoYWluLWRhdGEpKVxcbiAgICAgICAgICAgIH0pKVxcbiAgICAgICAgICAoeWllbGQgY3Jvc3NjaGFpbi1kZXRhaWxzIHRhcmdldC1jaGFpbilcXG4gICAgICAgICAgKSkpXFxuXFxuICAgIChzdGVwXFxuICAgICAgKHJlc3VtZVxcbiAgICAgICAgeyBcXFwicmVjZWl2ZXJcXFwiIDo9IHJlY2VpdmVyXFxuICAgICAgICAsIFxcXCJyZWNlaXZlci1ndWFyZFxcXCIgOj0gcmVjZWl2ZXItZ3VhcmRcXG4gICAgICAgICwgXFxcImFtb3VudFxcXCIgOj0gYW1vdW50XFxuICAgICAgICAsIFxcXCJzb3VyY2UtY2hhaW5cXFwiIDo9IHNvdXJjZS1jaGFpblxcbiAgICAgICAgfVxcblxcbiAgICAgICAgKGVtaXQtZXZlbnQgKFRSQU5TRkVSIFxcXCJcXFwiIHJlY2VpdmVyIGFtb3VudCkpXFxuICAgICAgICAoZW1pdC1ldmVudCAoVFJBTlNGRVJfWENIQUlOX1JFQ0QgXFxcIlxcXCIgcmVjZWl2ZXIgYW1vdW50IHNvdXJjZS1jaGFpbikpXFxuXFxuICAgICAgICA7OyBzdGVwIDIgLSBjcmVkaXQgY3JlYXRlIGFjY291bnQgb24gdGFyZ2V0IGNoYWluXFxuICAgICAgICAod2l0aC1jYXBhYmlsaXR5IChDUkVESVQgcmVjZWl2ZXIpXFxuICAgICAgICAgIChjcmVkaXQgcmVjZWl2ZXIgcmVjZWl2ZXItZ3VhcmQgYW1vdW50KSlcXG4gICAgICAgICkpXFxuICAgIClcXG5cXG5cXG4gIDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cXG4gIDsgQ29pbiBhbGxvY2F0aW9uc1xcblxcbiAgKGRlZnNjaGVtYSBhbGxvY2F0aW9uLXNjaGVtYVxcbiAgICBAZG9jIFxcXCJHZW5lc2lzIGFsbG9jYXRpb24gcmVnaXN0cnlcXFwiXFxuICAgIDtAbW9kZWwgWyAoaW52YXJpYW50ICg-PSBiYWxhbmNlIDAuMCkpIF1cXG5cXG4gICAgYmFsYW5jZTpkZWNpbWFsXFxuICAgIGRhdGU6dGltZVxcbiAgICBndWFyZDpndWFyZFxcbiAgICByZWRlZW1lZDpib29sKVxcblxcbiAgKGRlZnRhYmxlIGFsbG9jYXRpb24tdGFibGU6e2FsbG9jYXRpb24tc2NoZW1hfSlcXG5cXG4gIChkZWZ1biBjcmVhdGUtYWxsb2NhdGlvbi1hY2NvdW50XFxuICAgICggYWNjb3VudDpzdHJpbmdcXG4gICAgICBkYXRlOnRpbWVcXG4gICAgICBrZXlzZXQtcmVmOnN0cmluZ1xcbiAgICAgIGFtb3VudDpkZWNpbWFsXFxuICAgIClcXG5cXG4gICAgQGRvYyBcXFwiQWRkIGFuIGVudHJ5IHRvIHRoZSBjb2luIGFsbG9jYXRpb24gdGFibGUuIFRoaXMgZnVuY3Rpb24gXFxcXFxcbiAgICAgICAgIFxcXFxhbHNvIGNyZWF0ZXMgYSBjb3JyZXNwb25kaW5nIGVtcHR5IGNvaW4gY29udHJhY3QgYWNjb3VudCBcXFxcXFxuICAgICAgICAgXFxcXG9mIHRoZSBzYW1lIG5hbWUgYW5kIGd1YXJkLiBSZXF1aXJlcyBHRU5FU0lTIGNhcGFiaWxpdHkuIFxcXCJcXG5cXG4gICAgQG1vZGVsIFsgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IGFjY291bnQpKSBdXFxuXFxuICAgIChyZXF1aXJlLWNhcGFiaWxpdHkgKEdFTkVTSVMpKVxcblxcbiAgICAodmFsaWRhdGUtYWNjb3VudCBhY2NvdW50KVxcbiAgICAoZW5mb3JjZSAoPj0gYW1vdW50IDAuMClcXG4gICAgICBcXFwiYWxsb2NhdGlvbiBhbW91bnQgbXVzdCBiZSBub24tbmVnYXRpdmVcXFwiKVxcblxcbiAgICAoZW5mb3JjZS11bml0IGFtb3VudClcXG5cXG4gICAgKGxldFxcbiAgICAgICgoZ3VhcmQ6Z3VhcmQgKGtleXNldC1yZWYtZ3VhcmQga2V5c2V0LXJlZikpKVxcblxcbiAgICAgIChjcmVhdGUtYWNjb3VudCBhY2NvdW50IGd1YXJkKVxcblxcbiAgICAgIChpbnNlcnQgYWxsb2NhdGlvbi10YWJsZSBhY2NvdW50XFxuICAgICAgICB7IFxcXCJiYWxhbmNlXFxcIiA6IGFtb3VudFxcbiAgICAgICAgLCBcXFwiZGF0ZVxcXCIgOiBkYXRlXFxuICAgICAgICAsIFxcXCJndWFyZFxcXCIgOiBndWFyZFxcbiAgICAgICAgLCBcXFwicmVkZWVtZWRcXFwiIDogZmFsc2VcXG4gICAgICAgIH0pKSlcXG5cXG4gIChkZWZ1biByZWxlYXNlLWFsbG9jYXRpb25cXG4gICAgKCBhY2NvdW50OnN0cmluZyApXFxuXFxuICAgIEBkb2MgXFxcIlJlbGVhc2UgZnVuZHMgYXNzb2NpYXRlZCB3aXRoIGFsbG9jYXRpb24gQUNDT1VOVCBpbnRvIG1haW4gbGVkZ2VyLiAgIFxcXFxcXG4gICAgICAgICBcXFxcQUNDT1VOVCBtdXN0IGFscmVhZHkgZXhpc3QgaW4gbWFpbiBsZWRnZXIuIEFsbG9jYXRpb24gaXMgZGVhY3RpdmF0ZWQgXFxcXFxcbiAgICAgICAgIFxcXFxhZnRlciByZWxlYXNlLlxcXCJcXG4gICAgQG1vZGVsIFsgKHByb3BlcnR5ICh2YWxpZC1hY2NvdW50IGFjY291bnQpKSBdXFxuXFxuICAgICh2YWxpZGF0ZS1hY2NvdW50IGFjY291bnQpXFxuXFxuICAgICh3aXRoLXJlYWQgYWxsb2NhdGlvbi10YWJsZSBhY2NvdW50XFxuICAgICAgeyBcXFwiYmFsYW5jZVxcXCIgOj0gYmFsYW5jZVxcbiAgICAgICwgXFxcImRhdGVcXFwiIDo9IHJlbGVhc2UtdGltZVxcbiAgICAgICwgXFxcInJlZGVlbWVkXFxcIiA6PSByZWRlZW1lZFxcbiAgICAgICwgXFxcImd1YXJkXFxcIiA6PSBndWFyZFxcbiAgICAgIH1cXG5cXG4gICAgICAobGV0ICgoY3Vyci10aW1lOnRpbWUgKGF0ICdibG9jay10aW1lIChjaGFpbi1kYXRhKSkpKVxcblxcbiAgICAgICAgKGVuZm9yY2UgKG5vdCByZWRlZW1lZClcXG4gICAgICAgICAgXFxcImFsbG9jYXRpb24gZnVuZHMgaGF2ZSBhbHJlYWR5IGJlZW4gcmVkZWVtZWRcXFwiKVxcblxcbiAgICAgICAgKGVuZm9yY2VcXG4gICAgICAgICAgKD49IGN1cnItdGltZSByZWxlYXNlLXRpbWUpXFxuICAgICAgICAgIChmb3JtYXQgXFxcImZ1bmRzIGxvY2tlZCB1bnRpbCB7fS4gY3VycmVudCB0aW1lOiB7fVxcXCIgW3JlbGVhc2UtdGltZSBjdXJyLXRpbWVdKSlcXG5cXG4gICAgICAgICh3aXRoLWNhcGFiaWxpdHkgKFJFTEVBU0VfQUxMT0NBVElPTiBhY2NvdW50IGJhbGFuY2UpXFxuXFxuICAgICAgICAoZW5mb3JjZS1ndWFyZCBndWFyZClcXG5cXG4gICAgICAgICh3aXRoLWNhcGFiaWxpdHkgKENSRURJVCBhY2NvdW50KVxcbiAgICAgICAgICAoZW1pdC1ldmVudCAoVFJBTlNGRVIgXFxcIlxcXCIgYWNjb3VudCBiYWxhbmNlKSlcXG4gICAgICAgICAgKGNyZWRpdCBhY2NvdW50IGd1YXJkIGJhbGFuY2UpXFxuXFxuICAgICAgICAgICh1cGRhdGUgYWxsb2NhdGlvbi10YWJsZSBhY2NvdW50XFxuICAgICAgICAgICAgeyBcXFwicmVkZWVtZWRcXFwiIDogdHJ1ZVxcbiAgICAgICAgICAgICwgXFxcImJhbGFuY2VcXFwiIDogMC4wXFxuICAgICAgICAgICAgfSlcXG5cXG4gICAgICAgICAgXFxcIkFsbG9jYXRpb24gc3VjY2Vzc2Z1bGx5IHJlbGVhc2VkIHRvIG1haW4gbGVkZ2VyXFxcIikpXFxuICAgICkpKVxcblxcbilcXG5cIn19LFwic2lnbmVyc1wiOltdLFwibWV0YVwiOntcImNyZWF0aW9uVGltZVwiOjAsXCJ0dGxcIjoxNzI4MDAsXCJnYXNMaW1pdFwiOjAsXCJjaGFpbklkXCI6XCJcIixcImdhc1ByaWNlXCI6MCxcInNlbmRlclwiOlwiXCJ9LFwibm9uY2VcIjpcImNvaW4tY29udHJhY3QtdjZcIn0ifQ"
    ]