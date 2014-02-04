# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/accountsservice/accountsservice-0.6.35.ebuild,v 1.1 2013/12/04 19:38:30 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit autotools eutils gnome2 systemd

DESCRIPTION="D-Bus interfaces for querying and manipulating user account information"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/AccountsService/"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="doc +introspection systemd +ubuntu"
SRC_URI="${SRC_URI}
	https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}-0ubuntu6.debian.tar.gz"

# Want glib-2.34 for g_clear_pointer, bug #462938
RDEPEND="
	>=dev-libs/glib-2.34.0:2
	sys-auth/polkit
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
	systemd? ( >=sys-apps/systemd-186 )
	!systemd? ( sys-auth/consolekit )
"
DEPEND="${RDEPEND}
	app-crypt/gcr
	dev-libs/libxslt
	dev-util/gdbus-codegen
	>=dev-util/gtk-doc-am-1.15
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto )
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.35-gentoo-system-users.patch"

	# Daemon: rip out extension interface as it needs glib-2.37
	epatch "${FILESDIR}/${PN}-0.6.35-older-glib.patch"

	# Avoid deleting the root user (from 'master')
	epatch "${FILESDIR}/${PN}-0.6.35-nondelete-root.patch"

	# Change up user classification logic again (from 'master')
	epatch "${FILESDIR}/${PN}-0.6.35-user-logic.patch"

	# Ubuntu patches
	if use ubuntu; then
		einfo "Applying patches from Ubuntu:"
		for patch in `cat "${FILESDIR}/${P}-ubuntu-patch-series"`; do
			epatch "${WORKDIR}/debian/patches/${patch}"
		done

		# Only apply this patch if the systemd USE-flag is not set
		if ! use systemd; then
			epatch "${WORKDIR}/debian/patches/2002-disable_systemd.patch"
		fi
	fi

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--disable-more-warnings \
		--localstatedir="${EPREFIX}"/var \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--enable-admin-group="wheel" \
		$(use_enable doc docbook-docs) \
		$(use_enable introspection) \
		$(use_enable systemd) \
		$(systemd_with_unitdir)
}
