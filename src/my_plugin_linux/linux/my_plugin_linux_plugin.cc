#include "include/my_plugin/my_plugin_linux.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>

#include <cstring>

#define MY_PLUGIN_LINUX_PLATFORM(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), my_plugin_linux_get_type(), \
                              MyPluginLinuxPlatform))

struct _MyPluginLinuxPlatform {
  GObject parent_instance;
};

G_DEFINE_TYPE(MyPluginLinuxPlatform, my_plugin_linux, g_object_get_type())

// Called when a method call is received from Flutter.
static void my_plugin_linux_handle_method_call(
    MyPluginLinuxPlatform* self,
    FlMethodCall* method_call) {
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar* method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getPlatformName") == 0) {
    struct utsname uname_data = {};    
    g_autoptr(FlValue) result = fl_value_new_string("Linux");
    response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }

  fl_method_call_respond(method_call, response, nullptr);
}

static void my_plugin_linux_dispose(GObject* object) {
  G_OBJECT_CLASS(my_plugin_linux_parent_class)->dispose(object);
}

static void my_plugin_linux_class_init(MyPluginLinuxPlatform* klass) {
  G_OBJECT_CLASS(klass)->dispose = my_plugin_linux_dispose;
}

static void my_plugin_linux_init(MyPluginLinuxPlatform* self) {}

static void method_call_cb(FlMethodChannel* channel, FlMethodCall* method_call,
                           gpointer user_data) {
  MyPluginLinuxPlatform* plugin = MY_PLUGIN_LINUX_PLATFORM(user_data);
  my_plugin_linux_handle_method_call(plugin, method_call);
}

void my_plugin_linux_register_with_registrar(FlPluginRegistrar* registrar) {
  MyPluginLinuxPlatform* plugin = MY_PLUGIN_LINUX_PLATFORM(
      g_object_new(my_plugin_linux_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "my_plugin_linux",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}