# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-3.2.2-r2.ebuild,v 1.1 2011/12/15 23:46:04 tetromino Exp $

EAPI="4"

inherit eutils flag-o-matic gnome.org gnome2-utils libtool virtualx
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2"
SLOT="3"
# NOTE: This gtk+ has multi-gdk-backend support, see:
#  * http://blogs.gnome.org/kris/2010/12/29/gdk-3-0-on-mac-os-x/
#  * http://mail.gnome.org/archives/gtk-devel-list/2010-November/msg00099.html
# I tried this and got it all compiling, but the end result is unusable as it
# horribly mixes up the backends -- grobian
IUSE="aqua colord cups debug doc examples +introspection packagekit test vim-syntax xinerama"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
fi

# Testing is broken badly:
# https://bugzilla.gnome.org/show_bug.cgi?id=669562
RESTRICT="test"

# FIXME: introspection data is built against system installation of gtk+:3
# NOTE: cairo[svg] dep is due to bug 291283 (not patched to avoid eautoreconf)
# Use gtk+:2 for gtk-update-icon-cache and gtk-builder-convert
# >=x11-libs/gtk+-2.24:2 is needed for bug 359555
COMMON_DEPEND="!aqua? (
		x11-libs/libXrender
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXt
		x11-libs/libXext
		>=x11-libs/libXrandr-1.3
		x11-libs/libXcursor
		x11-libs/libXfixes
		x11-libs/libXcomposite
		x11-libs/libXdamage
		>=x11-libs/cairo-1.10.0[X,glib,svg]
		>=x11-libs/gdk-pixbuf-2.25.2:2[X,introspection?]
	)
	aqua? (
		>=x11-libs/cairo-1.10.0[aqua,glib,svg]
		>=x11-libs/gdk-pixbuf-2.25.2:2[introspection?]
	)
	xinerama? ( x11-libs/libXinerama )
	>=dev-libs/glib-2.31.18
	>=x11-libs/pango-1.29.0[introspection?]
	>=dev-libs/atk-2.1.5[introspection?]
	>=x11-libs/gtk+-2.24:2
	media-libs/fontconfig
	x11-misc/shared-mime-info
	colord? ( >=x11-misc/colord-0.1.9 )
	cups? ( net-print/cups )
	introspection? ( >=dev-libs/gobject-introspection-0.10.1 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/pkgconfig-0.9
	!aqua? (
		x11-proto/xextproto
		x11-proto/xproto
		x11-proto/inputproto
		x11-proto/damageproto
	)
	xinerama? ( x11-proto/xineramaproto )
	>=dev-util/gtk-doc-am-1.11
	doc? (
		>=dev-util/gtk-doc-1.11
		~app-text/docbook-xml-dtd-4.1.2 )
	test? (
		media-fonts/font-misc-misc
		media-fonts/font-cursor-misc )"
# gtk+-3.2.2 breaks Alt key handling in <=x11-libs/vte-0.30.1:2.90
RDEPEND="${COMMON_DEPEND}
	!<gnome-base/gail-1000
	!<x11-libs/vte-0.30.1-r1:2.90
	packagekit? ( app-admin/packagekit-base )"
PDEPEND="vim-syntax? ( app-vim/gtk-syntax )"

strip_builddir() {
	local rule=$1
	shift
	local directory=$1
	shift
	sed -e "s/^\(${rule} =.*\)${directory}\(.*\)$/\1\2/" -i $@ \
		|| die "Could not strip director ${directory} from build."
}

src_prepare() {
	# -O3 and company cause random crashes in applications. Bug #133469
	replace-flags -O3 -O2
	strip-flags

	# Non-working test in gentoo's env
	sed 's:\(g_test_add_func ("/ui-tests/keys-events.*\):/*\1*/:g' \
		-i gtk/tests/testing.c || die "sed 1 failed"
	sed '\%/recent-manager/add%,/recent_manager_purge/ d' \
		-i gtk/tests/recentmanager.c || die "sed 2 failed"

	# FIXME: multiple reftests fail when run from portage (but succeed when
	# run from a manual compile in a temp directory)
	sed -e 's:\(SUBDIRS.*\)reftests:\1:' \
		-i tests/Makefile.* || die "sed 3 failed"

	# Test results depend on the list of mounted filesystems!
	rm -v tests/a11y/pickers.{ui,txt} || die "rm failed"

	if ! use test; then
		# don't waste time building tests
		strip_builddir SRC_SUBDIRS tests Makefile.am
		[[ ${PV} != 9999 ]] && strip_builddir SRC_SUBDIRS tests Makefile.in
	fi

	if ! use examples; then
		# don't waste time building demos
		strip_builddir SRC_SUBDIRS demos Makefile.am
		[[ ${PV} != 9999 ]] && strip_builddir SRC_SUBDIRS demos Makefile.in
	fi

	[[ ${PV} = 9999 ]] && gnome2_src_prepare
}

src_configure() {
	local myconf="$(use_enable doc gtk-doc)
		$(use_enable xinerama)
		$(use_enable packagekit)
		$(use_enable cups cups auto)
		$(use_enable colord)
		$(use_enable introspection)
		--disable-papi
		--enable-gtk2-dependency"

	# XXX: Maybe with multi-backend we should enable x11 all the time?
	if use aqua; then
		myconf="${myconf} --enable-quartz-backend --disable-xinput"
	else
		myconf="${myconf} --enable-x11-backend --enable-xinput"
	fi

	# Passing --disable-debug is not recommended for production use
	use debug && myconf="${myconf} --enable-debug=yes"

	# need libdir here to avoid a double slash in a path that libtool doesn't
	# grok so well during install (// between $EPREFIX and usr ...)
	econf --libdir="${EPREFIX}/usr/$(get_libdir)" ${myconf}
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	# Exporting HOME fixes tests using XDG directories spec since all defaults
	# are based on $HOME. It is also backward compatible with functions not
	# yet ported to this spec.
	XDG_DATA_HOME="${T}" HOME="${T}" Xemake check || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /etc/gtk-3.0
	doins "${FILESDIR}"/settings.ini

	dodoc AUTHORS ChangeLog* HACKING NEWS* README*

	# Remove unneeded *.la files
	find "${D}" -name '*.la' -exec rm -f {} +

	# add -framework Carbon to the .pc files
	use aqua && for i in gtk+-3.0.pc gtk+-quartz-3.0.pc gtk+-unix-print-3.0.pc; do
		sed -i -e "s:Libs\: :Libs\: -framework Carbon :" "${ED}"usr/$(get_libdir)/pkgconfig/$i || die "sed failed"
	done
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update

	local GTK3_MODDIR="${EROOT}usr/$(get_libdir)/gtk-3.0/3.0.0"
	gtk-query-immodules-3.0  > "${GTK3_MODDIR}/immodules.cache" \
		|| ewarn "Failed to run gtk-query-immodules-3.0"

	if ! has_version "app-text/evince"; then
		elog "Please install app-text/evince for print preview functionality."
		elog "Alternatively, check \"gtk-print-preview-command\" documentation and"
		elog "add it to your settings.ini file."
	fi
}

pkg_postrm() {
	gnome2_schemas_update
}
