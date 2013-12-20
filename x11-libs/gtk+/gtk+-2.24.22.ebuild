# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.24.22.ebuild,v 1.4 2013/12/08 19:44:35 pacho Exp $

EAPI="5"

inherit eutils flag-o-matic gnome2-utils gnome.org multilib virtualx autotools readme.gentoo

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="aqua cups debug examples +introspection +ubuntu test vim-syntax xinerama"
SRC_URI="${SRC_URI}
	https://launchpad.net/ubuntu/+archive/primary/+files/gtk%2B2.0_${PV}-1ubuntu1.debian.tar.gz"

# NOTE: cairo[svg] dep is due to bug 291283 (not patched to avoid eautoreconf)
COMMON_DEPEND="
	!aqua? (
		x11-libs/libXrender
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXext
		>=x11-libs/libXrandr-1.3
		x11-libs/libXcursor
		x11-libs/libXfixes
		x11-libs/libXcomposite
		x11-libs/libXdamage
		>=x11-libs/cairo-1.6:=[X,svg]
		x11-libs/gdk-pixbuf:2[X,introspection?]
	)
	aqua? (
		>=x11-libs/cairo-1.6:=[aqua,svg]
		x11-libs/gdk-pixbuf:2[introspection?]
	)
	xinerama? ( x11-libs/libXinerama )
	>=dev-libs/glib-2.34:2
	>=x11-libs/pango-1.20[introspection?]
	>=dev-libs/atk-1.29.2[introspection?]
	media-libs/fontconfig
	x11-misc/shared-mime-info
	cups? ( net-print/cups:= )
	introspection? ( >=dev-libs/gobject-introspection-0.9.3 )
	!<gnome-base/gail-1000
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	!aqua? (
		x11-proto/xextproto
		x11-proto/xproto
		x11-proto/inputproto
		x11-proto/damageproto
	)
	xinerama? ( x11-proto/xineramaproto )
	>=dev-util/gtk-doc-am-1.11
	test? (
		x11-themes/hicolor-icon-theme
		media-fonts/font-misc-misc
		media-fonts/font-cursor-misc )
"

# gtk+-2.24.8 breaks Alt key handling in <=x11-libs/vte-0.28.2:0
# Add blocker against old gtk-builder-convert to be sure we maintain both
# in sync.
RDEPEND="${COMMON_DEPEND}
	!<dev-util/gtk-builder-convert-${PV}
	!<x11-libs/vte-0.28.2-r201:0
"
PDEPEND="vim-syntax? ( app-vim/gtk-syntax )"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="To make the gtk2 file chooser use 'current directory' mode by default,
edit ~/.config/gtk-2.0/gtkfilechooser.ini to contain the following:
[Filechooser Settings]
StartupMode=cwd"

strip_builddir() {
	local rule=$1
	shift
	local directory=$1
	shift
	sed -e "s/^\(${rule} =.*\)${directory}\(.*\)$/\1\2/" -i $@ \
		|| die "Could not strip director ${directory} from build."
}

set_gtk2_confdir() {
	# An arch specific config directory is used on multilib systems
	GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
}

src_prepare() {
	gnome2_environment_reset

	# Fix building due to moved definition, upstream bug #704766
	epatch "${FILESDIR}"/${PN}-2.24.20-darwin-quartz-pasteboard.patch

	# Ubuntu patches
	if use ubuntu; then
		einfo "Applying patches from Ubuntu:"
		for patch in `cat "${FILESDIR}/${P}-ubuntu-patch-series"`; do
			epatch "${WORKDIR}/debian/patches/${patch}"
		done
	fi

	# marshalers code was pre-generated with glib-2.31, upstream bug #671763
	rm -v gdk/gdkmarshalers.c gtk/gtkmarshal.c gtk/gtkmarshalers.c \
		perf/marshalers.c || die

	# Stop trying to build unmaintained docs, bug #349754
	strip_builddir SUBDIRS tutorial docs/Makefile.am docs/Makefile.in
	strip_builddir SUBDIRS faq docs/Makefile.am docs/Makefile.in

	# -O3 and company cause random crashes in applications. Bug #133469
	replace-flags -O3 -O2
	strip-flags

	use ppc64 && append-flags -mminimal-toc

	if ! use test; then
		# don't waste time building tests
		strip_builddir SRC_SUBDIRS tests Makefile.{am,in}
		strip_builddir SUBDIRS tests gdk/Makefile.{am,in} gtk/Makefile.{am,in}
	else
		# Non-working test in gentoo's env
		sed 's:\(g_test_add_func ("/ui-tests/keys-events.*\):/*\1*/:g' \
			-i gtk/tests/testing.c || die "sed 1 failed"

		# Cannot work because glib is too clever to find real user's home
		# gentoo bug #285687, upstream bug #639832
		# XXX: /!\ Pay extra attention to second sed when bumping /!\
		sed '/TEST_PROGS.*recentmanager/d' -i gtk/tests/Makefile.am \
			|| die "failed to disable recentmanager test (1)"
		sed '/^TEST_PROGS =/,+3 s/recentmanager//' -i gtk/tests/Makefile.in \
			|| die "failed to disable recentmanager test (2)"
		sed 's:\({ "GtkFileChooserButton".*},\):/*\1*/:g' -i gtk/tests/object.c \
			|| die "failed to disable recentmanager test (3)"

		# Skip tests known to fail
		# https://bugzilla.gnome.org/show_bug.cgi?id=646609
		sed -e '/g_test_add_func.*test_text_access/s:^://:' \
			-i "${S}/gtk/tests/testing.c" || die

		# https://bugzilla.gnome.org/show_bug.cgi?id=617473
		sed -i -e 's:pltcheck.sh:$(NULL):g' \
			gtk/Makefile.am || die

		# UI tests require immodules already installed; bug #413185
		if ! has_version 'x11-libs/gtk+:2'; then
			ewarn "Disabling UI tests because this is the first install of"
			ewarn "gtk+:2 on this machine. Please re-run the tests after $P"
			ewarn "has been installed."
			sed '/g_test_add_func.*ui-tests/ d' \
				-i gtk/tests/testing.c || die "sed 2 failed"
		fi
	fi

	if ! use examples; then
		# don't waste time building demos
		strip_builddir SRC_SUBDIRS demos Makefile.am Makefile.in
	fi

	epatch_user

	eautoreconf
	# Use elibtoolize in place of eautoreconf when it will be dropped
	#elibtoolize
}

src_configure() {
	# Passing --disable-debug is not recommended for production use
	econf \
		$(usex aqua --with-gdktarget=quartz --with-gdktarget=x11) \
		$(usex aqua "" --with-xinput) \
		$(usex debug --enable-debug=yes "") \
		$(use_enable cups cups auto) \
		$(use_enable introspection) \
		$(use_enable xinerama) \
		--disable-papi
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check
}

src_install() {
	default

	# see bug #133241
	echo 'gtk-fallback-icon-theme = "gnome"' > "${T}/gtkrc"
	insinto /usr/share/gtk-2.0
	doins "${T}"/gtkrc

	dodoc AUTHORS ChangeLog* HACKING NEWS* README*

	# add -framework Carbon to the .pc files
	use aqua && for i in gtk+-2.0.pc gtk+-quartz-2.0.pc gtk+-unix-print-2.0.pc; do
		sed -i -e "s:Libs\: :Libs\: -framework Carbon :" "${ED%/}"/usr/lib/pkgconfig/$i || die "sed failed"
	done

	# dev-util/gtk-builder-convert split off into a separate package, #402905
	rm "${ED}"usr/bin/gtk-builder-convert

	prune_libtool_files --modules

	readme.gentoo_create_doc
}

pkg_postinst() {
	set_gtk2_confdir

	gtk-query-immodules-2.0 --update-cache || die "Update immodules cache failed"

	if [ -e "${EROOT%/}/etc/gtk-2.0/gtk.immodules" ]; then
		elog "File /etc/gtk-2.0/gtk.immodules has been moved to \$CHOST"
		elog "aware location. Removing deprecated file."
		rm -f ${EROOT%/}/etc/gtk-2.0/gtk.immodules
	fi

	if [ -e "${EROOT%/}${GTK2_CONFDIR}/gtk.immodules" ]; then
		elog "File /etc/gtk-2.0/gtk.immodules has been moved to"
		elog "${EROOT%/}/usr/$(get_libdir)/gtk-2.0/2.10.0/immodules.cache"
		elog "Removing deprecated file."
		rm -f ${EROOT%/}${GTK2_CONFDIR}/gtk.immodules
	fi

	# pixbufs are now handled by x11-libs/gdk-pixbuf
	if [ -e "${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders" ]; then
		elog "File ${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders is now handled by x11-libs/gdk-pixbuf"
		elog "Removing deprecated file."
		rm -f ${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders
	fi

	# two checks needed since we dropped multilib conditional
	if [ -e "${EROOT%/}/etc/gtk-2.0/gdk-pixbuf.loaders" ]; then
		elog "File ${EROOT%/}/etc/gtk-2.0/gdk-pixbuf.loaders is now handled by x11-libs/gdk-pixbuf"
		elog "Removing deprecated file."
		rm -f ${EROOT%/}/etc/gtk-2.0/gdk-pixbuf.loaders
	fi

	if [ -e "${EROOT%/}"/usr/lib/gtk-2.0/2.[^1]* ]; then
		elog "You need to rebuild ebuilds that installed into" "${EROOT%/}"/usr/lib/gtk-2.0/2.[^1]*
		elog "to do that you can use qfile from portage-utils:"
		elog "emerge -va1 \$(qfile -qC ${EPREFIX}/usr/lib/gtk-2.0/2.[^1]*)"
	fi

	if ! has_version "app-text/evince"; then
		elog "Please install app-text/evince for print preview functionality."
		elog "Alternatively, check \"gtk-print-preview-command\" documentation and"
		elog "add it to your gtkrc."
	fi

	readme.gentoo_print_elog
}
