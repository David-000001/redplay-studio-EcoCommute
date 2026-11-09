package com.example.um_ecocommute;

import androidx.test.core.app.ActivityScenario;
import androidx.test.core.app.ApplicationProvider;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import androidx.test.espresso.NoMatchingViewException;
import com.example.um_ecocommute.auth.AuthRepository;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.firestore.FirebaseFirestoreException;
import org.junit.Test;
import org.junit.runner.RunWith;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.ExecutionException;
import static androidx.test.espresso.Espresso.onView;
import static androidx.test.espresso.action.ViewActions.*;
import static androidx.test.espresso.assertion.ViewAssertions.*;
import static androidx.test.espresso.matcher.ViewMatchers.*;
import static org.junit.Assert.*;

@RunWith(AndroidJUnit4.class)
public class NativeFlowTest {
 private AuthRepository repository() {
   assertTrue("Tests must use localDebug",BuildConfig.USE_EMULATORS);
   return ((EcoCommuteApplication)ApplicationProvider.getApplicationContext()).repository();
 }
 private void waitText(int id, String text) throws Exception {
   long deadline=System.currentTimeMillis()+20000;
   while(true) {
     try { onView(withId(id)).check(matches(withText(text))); return; }
     catch(AssertionError | NoMatchingViewException e) {
       if(System.currentTimeMillis()>deadline) throw e;
       Thread.sleep(200);
     }
   }
 }
 @Test public void navigationAndRotationRetainDestination() {
   try(ActivityScenario<MainActivity> activity=ActivityScenario.launch(MainActivity.class)) {
     onView(withId(R.id.climate)).perform(scrollTo(),click());
     onView(withId(R.id.title)).check(matches(withText(R.string.climate)));
     activity.recreate();
     onView(withId(R.id.title)).check(matches(withText(R.string.climate)));
     onView(withId(R.id.back)).perform(scrollTo(),click());
     onView(withId(R.id.accounts)).check(matches(isDisplayed()));
   }
 }
 @Test public void nativeAccountUiSignsInEditsAndSignsOut() throws Exception {
   AuthRepository repo=repository();repo.signOut();
   try(ActivityScenario<MainActivity> activity=ActivityScenario.launch(MainActivity.class)) {
     onView(withId(R.id.accounts)).perform(scrollTo(),click());
     onView(withId(R.id.email)).perform(scrollTo(),replaceText("student@foodloop.test"));
     onView(withId(R.id.password)).perform(scrollTo(),replaceText("FoodLoop-local-2026!"),closeSoftKeyboard());
     onView(withId(R.id.sign_in)).perform(scrollTo(),click());
     waitText(R.id.profile_summary,"Local student\nRole: student");
     onView(withId(R.id.profile_name)).perform(scrollTo(),replaceText("Native student"),closeSoftKeyboard());
     onView(withId(R.id.save_name)).perform(scrollTo(),click());
     waitText(R.id.message,"Display name saved.");
     activity.recreate();
     waitText(R.id.profile_summary,"Native student\nRole: student");
     onView(withId(R.id.sign_out)).perform(scrollTo(),click());
     onView(withId(R.id.sign_in)).perform(scrollTo()).check(matches(isDisplayed()));
   } finally { repo.signOut(); }
 }
 @Test public void nativeRepositoryRegistrationAndRoleBoundary() throws Exception {
   AuthRepository repo=repository();repo.signOut();
   String email="native-"+System.currentTimeMillis()+"@foodloop.test";
   try {
     Tasks.await(repo.register(email,"Native-test-2026!","Native test"),30,TimeUnit.SECONDS);
     String uid=repo.auth.getCurrentUser().getUid();
     assertEquals("student",Tasks.await(repo.profile(uid).get(),20,TimeUnit.SECONDS).getString("role"));
     try {
       Tasks.await(repo.profile(uid).update("role","admin"),20,TimeUnit.SECONDS);
       fail("Student escalation must be denied");
     } catch(ExecutionException e) {
       assertTrue(e.getCause() instanceof FirebaseFirestoreException);
       assertEquals(FirebaseFirestoreException.Code.PERMISSION_DENIED,((FirebaseFirestoreException)e.getCause()).getCode());
     }
     Tasks.await(repo.resetPassword(email),20,TimeUnit.SECONDS);
     Tasks.await(repo.requestVendor(),20,TimeUnit.SECONDS);
     repo.signOut();
     Tasks.await(repo.signIn("admin@foodloop.test","FoodLoop-local-2026!"),20,TimeUnit.SECONDS);
     Tasks.await(repo.approveVendor(uid),20,TimeUnit.SECONDS);
     repo.signOut();
     Tasks.await(repo.signIn(email,"Native-test-2026!"),20,TimeUnit.SECONDS);
     assertEquals("vendor",Tasks.await(repo.profile(uid).get(),20,TimeUnit.SECONDS).getString("role"));
     assertEquals("approved",Tasks.await(repo.profile(uid).get(),20,TimeUnit.SECONDS).getString("vendorStatus"));
   } finally { repo.signOut(); }
   // The CI emulator process owns and discards all synthetic records at exit.
 }
}
